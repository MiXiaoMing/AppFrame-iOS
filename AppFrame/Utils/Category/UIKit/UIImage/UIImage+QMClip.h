//
//  UIImage+QMClip.h
//  AppFrame
//
//  Created by edz on 2019/8/1.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QMClip)
/**
 裁剪为有边界的圆形图片
 
 @param borderWidth 边宽
 @param borderColor 边颜色
 */
- (UIImage *)clipImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 裁剪图片中的一块区域
 
 @param clipRect 裁剪区域
 */
- (UIImage *)imageClipRect:(CGRect)clipRect;
/**
 拉伸图片
 @param edgeInsets 不进行拉伸的区域
 */
- (UIImage *)stretchableWithedgeInsets:(UIEdgeInsets)edgeInsets;
/**
 改变图片尺寸
 
 @param newSize 新尺寸
 @param isScale 是否按照比例转换
 */
- (UIImage *)imageChangeSize:(CGSize)newSize isScale:(BOOL)isScale;

/**
 裁剪图片圆角
 
 @param targetSize 目标尺寸
 @param cornerRadius 圆角大小
 @param corners 圆角位置
 @param backgroundColor 背景颜色
 @param isEqualScale 是否等比缩放
 */
- (UIImage *)clipToSize:(CGSize)targetSize
           cornerRadius:(CGFloat)cornerRadius
                corners:(UIRectCorner)corners
        backgroundColor:(UIColor *)backgroundColor
           isEqualScale:(BOOL)isEqualScale;
/**
 裁剪为全圆角图片
 */
- (UIImage *)clipToCornerImageWithCornerRadius:(CGFloat)cornerRadius;

/**
 裁剪圆角图片
 
 @param cornerRadius 圆角大小
 @param corners 圆角位置
 */
- (UIImage *)clipToCornerImageWithCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners;
@end

NS_ASSUME_NONNULL_END
