//
//  QMBaseNavigationController.m
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "QMBaseNavigationController.h"
#import "UIImage+QMGenerate.h"
@interface QMBaseNavigationController ()

@end

@implementation QMBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *barImg = [UIImage squareImageWithColor:[UIColor whiteColor] targetSize:CGSizeMake(500, 88.)];
    [self.navigationBar setBackgroundImage:barImg forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage squareImageWithColor:[UIColor colorWithRed:231/255. green:231/255. blue:231/255. alpha:1] targetSize:CGSizeMake(500, 1)]];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

@end
