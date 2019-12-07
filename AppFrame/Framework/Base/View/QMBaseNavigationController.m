//
//  QMBaseNavigationController.m
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "QMBaseNavigationController.h"
#import "UIImage+QMGenerate.h"
#import "UIKitGlobalHeader.h"
#import "UIBarButtonItem+QMCreat.h"
#import "NSBundle+QMPod.h"

@interface QMBaseNavigationController ()

@end

@implementation QMBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *barImg = [UIImage squareImageWithColor:[UIColor whiteColor] targetSize:CGSizeMake(500, 88.)];
    UIImage *barImg = [UIImage squareImageWithColor:kColorWith_RGB_Hex(0xe73736) targetSize:CGSizeMake(KSCREEN_WIDTH, 88)];
    [self.navigationBar setBackgroundImage:barImg forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setTitleTextAttributes:@{@"NSFontAttributeName" : kFont(18)]}];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 非根控制器
    if (self.childViewControllers.count > 0) {
        // 设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:[NSBundle getPodImageWith:@"AppFrame" fileName:@"top_icon_back" type:@"png"] itemSpaces:QMBarItemSpaceMake(15, 15)];
        
        // 隐藏TabBar
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    
    // 真正跳转
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
