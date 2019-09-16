//
//  UIColor+QM.h
//  AppFrame
//
//  Created by edz on 2019/8/27.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (QM)

/**
 传入十六进制颜色
 */
+ (UIColor *)colorFromRGBA:(int)RGBA;

/**
 传入十六进制字符串色值（透明度默认为1）
 */
+ (UIColor *)hexColorWithString:(NSString *)string;

/**
 传入十六进制字符串色值
 */
+ (UIColor *)hexColorWithString:(NSString *)string alpha:(float)alpha;

+ (UIColor *)hexColorWithInt:(int)hex alpha:(float)alpha;

@end

NS_ASSUME_NONNULL_END
