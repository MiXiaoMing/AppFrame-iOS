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
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

- (void)setNavigationBarBackgroundColor:(UIColor *)color {
    UIImage *barImg = [UIImage squareImageWithColor:color targetSize:CGSizeMake(KSCREEN_WIDTH, 88)];
    [self.navigationBar setBackgroundImage:barImg forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}

@end
