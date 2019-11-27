//
//  UIButton+QMGenerate.h
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (QMGenerate)

/**
 创建长方形圆角按钮
 */
+ (instancetype)creatCornerSquareButtonWith:(NSString *)title color:(UIColor *)color;

+ (UIButton *)createButtonWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)color andTitle:(NSString *)title andTitleFont:(NSInteger)fontSize class:(id)classObject action:(SEL)action;
+ (UIButton *)createButtonWithFrame:(CGRect)frame andImage:(NSString *)imageName;
+ (UIButton *)createButtonWithFrame:(CGRect)frame andTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroudColor;
+ (UIButton *)createButtonWithFrame:(CGRect)frame andSetImage:(NSString *)imageName;
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
+ (UIButton *)createBlueWidthButtonWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)color andTitle:(NSString *)title andTitleFont:(NSInteger)fontSize class:(id)classObject action:(SEL)action ;
+ (UIButton *)createButtonWithFrame:(CGRect)frame andSetImage:(NSString *)imageName andTitle:(NSString *)title andTitleFont:(UIFont *)titleFont andTitleColor:(UIColor *)titleColor;

+ (UIButton *)configReplyButtonWithAlignment:(UIControlContentHorizontalAlignment)aligment;
+ (UIButton *)configBUttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundcolor:(UIColor *)backgroundColor titleFont:(UIFont *)titleFont;


+ (UIButton *)configBadgeButton;
- (void)adaptBadgeButton;
@end

NS_ASSUME_NONNULL_END
