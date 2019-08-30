//
//  QMBaseTabBarController.h
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMBaseTabBarController : UITabBarController

- (void)setUpTabBarItemTextAttributes:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

@end

NS_ASSUME_NONNULL_END
