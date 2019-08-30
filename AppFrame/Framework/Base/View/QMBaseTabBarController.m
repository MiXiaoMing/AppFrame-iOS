//
//  QMBaseTabBarController.m
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "QMBaseTabBarController.h"
#import "UIImage+QMGenerate.h"
@interface QMBaseTabBarController ()

@end

@implementation QMBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage squareImageWithColor:[UIColor whiteColor] targetSize:CGSizeMake(500, 49.)]];
    [[UITabBar appearance] setShadowImage:[UIImage squareImageWithColor:[UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1] targetSize:CGSizeMake(500, 1.)]];
}
- (void)setUpTabBarItemTextAttributes:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor
{
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:26/255. green:26/255. blue:26/255. alpha:1];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = selectedColor;
    
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end
