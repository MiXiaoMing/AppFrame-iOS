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

/**
 设置全局返回按钮图片
 */
+ (void)setAppearBackImage:(UIImage *)image;

/** 初始化空白页状态,子类复写*/
- (void)setEmptyViewInitialState;

/**
 设置标题颜色和字体
 */
- (void)setNavigationBarTitleColor:(nullable UIColor *)color titleFont:(nullable UIFont *)titleFont;
@end

NS_ASSUME_NONNULL_END
