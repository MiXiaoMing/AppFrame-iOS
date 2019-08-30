//
//  UINavigationController+QMFullScreen.m
//  CustomNavigationBar
//
//  Created by Barnett on 2017/12/30.
//  Copyright © 2017年 ZQM. All rights reserved.
//

#import "UINavigationController+QMFullScreen.h"
#import "NSObject+QM.h"
#import <objc/runtime.h>
@implementation UIViewController (QMFullScreen)

-(BOOL)QM_disableInteractivePop{
    return [objc_getAssociatedObject(self, @selector(QM_disableInteractivePop)) boolValue];
}

- (void)setQM_disableInteractivePop:(BOOL)QM_disableInteractivePop
{
    objc_setAssociatedObject(self, @selector(QM_disableInteractivePop), @(QM_disableInteractivePop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UINavigationController (QMFullScreen)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleClassInstanceMethodWithOriginSel:@selector(viewDidLoad) swizzleSel:@selector(QM_viewDidLoad)];
    });
}

-(void)QM_viewDidLoad {
    //接替系统滑动返回手势
    NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
    id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    
    UIPanGestureRecognizer * fullScreenGesture = [[UIPanGestureRecognizer alloc]initWithTarget:internalTarget action:handler];
    fullScreenGesture.delegate = self;
    fullScreenGesture.maximumNumberOfTouches = 1;
    
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    [targetView addGestureRecognizer:fullScreenGesture];
    
    [self.interactivePopGestureRecognizer setEnabled:NO];
    
    [self QM_viewDidLoad];
}

/**
 全屏滑动返回判断
 
 @param gestureRecognizer 手势
 @return 是否响应
 */
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (self.topViewController.QM_disableInteractivePop) {
        return NO;
    }
    
    if ([gestureRecognizer translationInView:gestureRecognizer.view].x <= 0) {
        return NO;
    }
    
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    return (self.childViewControllers.count != 1);
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && [otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]);
}



@end
