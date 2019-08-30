//
//  UIViewController+QM.m
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIViewController+QM.h"

@implementation UIViewController (QM)

- (UIViewController *)currentViewController{
    UIViewController *currentViewController = [self topMostController];
    while ([currentViewController isKindOfClass:[UINavigationController class]] || [currentViewController isKindOfClass:[UITabBarController class]]) {
        if ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController *)currentViewController topViewController]) {
            currentViewController = [(UINavigationController *)currentViewController topViewController];
        } else if ([currentViewController isKindOfClass:[UITabBarController class]] && [(UITabBarController *)currentViewController selectedViewController]) {
            currentViewController = [(UITabBarController *)currentViewController selectedViewController];
        }
    }
    currentViewController = [currentViewController topMostController];
    
    return currentViewController;
}

- (UIViewController *)topMostController{
    UIViewController *topController = self;
    while ([topController presentedViewController])
        
        topController = [topController presentedViewController];
    
    return topController;
}

@end
