//
//  QMBaseViewController.h
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMBaseViewController : UIViewController

/**
 返回按钮
 */
- (void)creatLeftReturnBarButtonItem;

/**
 返回按钮点击
 */
- (void)clickLeftBarButtonItem;

/**
 设置导航栏颜色
 */
- (void)setStatusBarBackgroundColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
