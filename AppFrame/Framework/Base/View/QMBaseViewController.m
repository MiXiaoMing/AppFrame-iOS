//
//  QMBaseViewController.m
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "QMBaseViewController.h"
#import "NSBundle+QMPod.h"
#import "UIBarButtonItem+QMCreat.h"

static UIImage *leftBackImage;

@interface QMBaseViewController ()

@property (nonatomic,strong) UIImage *leftBackImage;
@property (nonatomic, assign) BOOL isNeedUpdate;

@end

@implementation QMBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isNeedUpdate) {
        [self.view setNeedsLayout];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    self.isNeedUpdate=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (self.navigationController.viewControllers.count != 1) {
        [self creatLeftReturnBarButtonItem];
    }
    self.isNeedUpdate=YES;
}
/**
 返回按钮点击
 */
- (void)clickLeftBarButtonItem {
    if (self.navigationController.viewControllers.count != 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

/**
 返回按钮
 */
- (void)creatLeftReturnBarButtonItem
{
    UIImage *image;
    if (leftBackImage) {
        image = leftBackImage;
    }else
    {
        image = [NSBundle getPodImageWith:@"AppFrame" fileName:@"NavigationBack" type:@"png"];
//        image = [NSBundle getPodImageWith:nil fileName:@"NavigationBack" type:@"png"];
    }
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickLeftBarButtonItem) image:image itemSpaces:QMBarItemSpaceMake(15, 15)];
}
+ (void)setAppearBackImage:(UIImage *)image
{
    leftBackImage = image;
}

- (void)setEmptyViewInitialState
{
    
}

- (void)setNavigationBarTitleColor:(nullable UIColor *)color titleFont:(nullable UIFont *)titleFont
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (color != nil) {
        [dic setObject:color forKey:NSForegroundColorAttributeName];
    }
    if (titleFont != nil) {
        [dic setObject:titleFont forKey:NSFontAttributeName];
    }
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self updateNavLayout];
}
- (void)updateNavLayout{
    if (@available(iOS 13.0,*)) {
        if (!self.isNeedUpdate || self.navigationController == nil) {
            return;
        }
        self.isNeedUpdate=NO;
        
        for (UIView *subview in self.navigationController.navigationBar.subviews) {
            if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
                //可修正iOS13之后的偏移
                NSArray *contentViewConstraint = subview.constraints;
                for (NSLayoutConstraint * constant in contentViewConstraint) {
                    if (fabs(constant.constant) <= 20) {
                        constant.constant=0;
                    }
                }
                if (subview.subviews.count > 0) {
                    for (UIView *stackView in subview.subviews) {
                        if ([NSStringFromClass(stackView.class) containsString:@"StackView"]) {
                            NSArray *stackViewConstraint = stackView.constraints;
                            for (NSLayoutConstraint * constant in stackViewConstraint) {
                                if (fabs(constant.constant) <= 8) {
                                    constant.constant=0;
                                }
                            }
                        }
                    }
                }
                break;
            }
        }
    }
}
@end
