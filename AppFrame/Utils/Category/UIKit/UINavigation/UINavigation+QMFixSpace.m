//
//  UINavigation+QMFixSpace.m
//  CustomNavigationBar
//

#import "UINavigation+QMFixSpace.h"
#import "NSObject+QM.h"
#import <Availability.h>
#import <objc/runtime.h>
#define QM_defaultFixSpace 0

static BOOL QM_disableFixSpace = NO;
static BOOL QM_tempDisableFixSpace = NO;
static NSInteger QM_tempBehavior = 0;

@implementation UINavigationController (QMFixSpace)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleClassInstanceMethodWithOriginSel:@selector(viewWillAppear:)
                                           swizzleSel:@selector(QM_viewWillAppear:)];
        [self swizzleClassInstanceMethodWithOriginSel:@selector(viewWillDisappear:)
                                           swizzleSel:@selector(QM_viewWillDisappear:)];
        if (@available(iOS 11.0,*)) {
            [self swizzleClassInstanceMethodWithOriginSel:@selector(pushViewController:animated:)
                                               swizzleSel:@selector(QM_pushViewController:animated:)];
            
            [self swizzleClassInstanceMethodWithOriginSel:@selector(popViewControllerAnimated:)
                                               swizzleSel:@selector(QM_popViewControllerAnimated:)];
            
            [self swizzleClassInstanceMethodWithOriginSel:@selector(popToViewController:animated:)
                                               swizzleSel:@selector(QM_popToViewController:animated:)];
            
            [self swizzleClassInstanceMethodWithOriginSel:@selector(popToRootViewControllerAnimated:)
                                               swizzleSel:@selector(QM_popToRootViewControllerAnimated:)];
            
            [self swizzleClassInstanceMethodWithOriginSel:@selector(setViewControllers:animated:)
                                               swizzleSel:@selector(QM_setViewControllers:animated:)];
        }
    });
}

-(void)QM_viewWillAppear:(BOOL)animated {
    if ([self isKindOfClass:[UIImagePickerController class]]) {
        QM_tempDisableFixSpace = QM_disableFixSpace;
        QM_disableFixSpace = YES;

        if (@available(iOS 11.0, *)) {
            QM_tempBehavior = [UIScrollView appearance].contentInsetAdjustmentBehavior;
            [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
    }
    [self QM_viewWillAppear:animated];
}

-(void)QM_viewWillDisappear:(BOOL)animated{
    if ([self isKindOfClass:[UIImagePickerController class]]) {
        QM_disableFixSpace = QM_tempDisableFixSpace;

        if (@available(iOS 11.0, *)) {
            [UIScrollView appearance].contentInsetAdjustmentBehavior = QM_tempBehavior;
        }
    }
    [self QM_viewWillDisappear:animated];
}

-(void)QM_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self QM_pushViewController:viewController animated:animated];
    QM_disableFixSpace = ![self judgeNewControllerIsInFrame:viewController];
    if (!animated || QM_disableFixSpace) {
        [self.navigationBar setNeedsLayout];
    }
}

- (nullable UIViewController *)QM_popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = [self QM_popViewControllerAnimated:animated];
    QM_disableFixSpace = ![self judgeNewControllerIsInFrame:[self.viewControllers lastObject]];
    if (!animated || QM_disableFixSpace) {
        [self.navigationBar setNeedsLayout];
    }
    return vc;
}

- (nullable NSArray<__kindof UIViewController *> *)QM_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSArray *vcs = [self QM_popToViewController:viewController animated:animated];
    QM_disableFixSpace = ![self judgeNewControllerIsInFrame:viewController];
    if (!animated || QM_disableFixSpace) {
        [self.navigationBar setNeedsLayout];
    }
    return vcs;
}

- (nullable NSArray<__kindof UIViewController *> *)QM_popToRootViewControllerAnimated:(BOOL)animated{
    NSArray *vcs = [self QM_popToRootViewControllerAnimated:animated];
    QM_disableFixSpace = ![self judgeNewControllerIsInFrame:[self.viewControllers lastObject]];
    if (!animated || QM_disableFixSpace) {
        [self.navigationBar setNeedsLayout];
    }
    return vcs;
}

- (void)QM_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated NS_AVAILABLE_IOS(3_0){
    [self QM_setViewControllers:viewControllers animated:animated];
    QM_disableFixSpace = ![self judgeNewControllerIsInFrame:[viewControllers lastObject]];
    if (!animated || QM_disableFixSpace) {
        [self.navigationBar setNeedsLayout];
    }
}
// 判断是否属于组件
- (BOOL)judgeNewControllerIsInFrame:(UIViewController *)viewController
{
    Class superClass = viewController.class;
    BOOL flag = false;
    while (![NSStringFromClass(superClass) isEqualToString:NSStringFromClass([UIViewController class])]) {
        if ([NSStringFromClass(superClass) isEqualToString:@"QMBaseViewController"]) {
            flag = true;
            break;
        }
        superClass = [superClass superclass];
    }
    return flag;
}

@end

@implementation UINavigationBar (QMFixSpace)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleClassInstanceMethodWithOriginSel:@selector(layoutSubviews) swizzleSel:@selector(QM_layoutSubviews)];
    });
}

-(void)QM_layoutSubviews{
    [self QM_layoutSubviews];
    
    if (@available(iOS 11.0,*)) {
        if (!QM_disableFixSpace) {
            if (@available(iOS 13.0,*)) {
                
            }else
            {
                self.layoutMargins = UIEdgeInsetsZero;
                CGFloat space = QM_defaultFixSpace;
                for (UIView *subview in self.subviews) {
                    if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
                        //可修正iOS11之后的偏移
                        subview.layoutMargins = UIEdgeInsetsMake(0, space, 0, space);
                        break;
                    }
                }
            }
        }else
        {
            self.layoutMargins = UIEdgeInsetsMake(0, 16, 0, 16);
            for (UIView *subview in self.subviews) {
                if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
                    //可修正iOS11之后的偏移
                    subview.layoutMargins = UIEdgeInsetsMake(0, 16, 0, 16);
                    break;
                }
            }
        }
    }
}

@end

@implementation UINavigationItem (QMFixSpace)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleClassInstanceMethodWithOriginSel:@selector(setLeftBarButtonItem:)
                                           swizzleSel:@selector(QM_setLeftBarButtonItem:)];
        
        [self swizzleClassInstanceMethodWithOriginSel:@selector(setLeftBarButtonItems:)
                                           swizzleSel:@selector(QM_setLeftBarButtonItems:)];
        
        [self swizzleClassInstanceMethodWithOriginSel:@selector(setRightBarButtonItem:)
                                           swizzleSel:@selector(QM_setRightBarButtonItem:)];
        
        [self swizzleClassInstanceMethodWithOriginSel:@selector(setRightBarButtonItems:)
                                           swizzleSel:@selector(QM_setRightBarButtonItems:)];
    });
    
}

-(void)QM_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    if (@available(iOS 11.0,*)) {
        [self QM_setLeftBarButtonItem:leftBarButtonItem];
    } else {
        if (!QM_disableFixSpace && leftBarButtonItem) {
            //存在按钮且需要调节
            [self setLeftBarButtonItems:@[leftBarButtonItem]];
        } else {//不存在按钮,或者不需要调节
            [self QM_setLeftBarButtonItem:leftBarButtonItem];
        }
    }
}

-(void)QM_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems {
    if (leftBarButtonItems.count) {
        NSMutableArray *items = [NSMutableArray arrayWithObject:[self fixedSpaceWithWidth:QM_disableFixSpace-20]];//可修正iOS11之前的偏移
        [items addObjectsFromArray:leftBarButtonItems];
        [self QM_setLeftBarButtonItems:items];
    } else {
        [self QM_setLeftBarButtonItems:leftBarButtonItems];
    }
}

-(void)QM_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem{
    if (@available(iOS 11.0,*)) {
        [self QM_setRightBarButtonItem:rightBarButtonItem];
    } else {
        if (!QM_disableFixSpace && rightBarButtonItem) {
            [self setRightBarButtonItems:@[rightBarButtonItem]];
        } else {
            [self QM_setRightBarButtonItem:rightBarButtonItem];
        }
    }
}

-(void)QM_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems{
    if (rightBarButtonItems.count) {
        NSMutableArray *items = [NSMutableArray arrayWithObject:[self fixedSpaceWithWidth:QM_defaultFixSpace-20]];
        [items addObjectsFromArray:rightBarButtonItems];
        [self QM_setRightBarButtonItems:items];
    } else {
        [self QM_setRightBarButtonItems:rightBarButtonItems];
    }
}


/**
 占位item
 */
-(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end

