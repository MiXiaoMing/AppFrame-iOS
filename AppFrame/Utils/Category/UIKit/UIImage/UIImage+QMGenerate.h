//
//  UIImage+QMGenerate.h
//  AppFrame
//
//  Created by edz on 2019/8/1.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QMGenerate)

/**
 生成vImage模糊图片
 
 @param degree 模糊数值(0-1)
 */
- (UIImage *)boxblurImageWithBlurNumber:(CGFloat)degree;

/**
 生成带圆角的颜色图片
 
 @param color 图片颜色
 @param targetSize 生成尺寸
 @param cornerRadius 圆角大小
 @param backgroundColor 背景颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color targetSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor;

/**
 生成矩形的颜色图片
 
 @param color 图片颜色
 @param targetSize 生成尺寸
 */
+ (UIImage *)squareImageWithColor:(UIColor *)color targetSize:(CGSize)targetSize;

/**
 生成带圆角的颜色图片,背景默认白色
 
 @param color 图片颜色
 @param targetSize 生成尺寸
 @param cornerRadius 圆角大小
 */
+ (UIImage *)imageWithColor:(UIColor *)color targetSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius;
@end
