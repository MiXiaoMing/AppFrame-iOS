//
//  NSString+QM.h
//  Module
//
//  Created by edz on 2019/7/30.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (QM)

#pragma mark - 实例方法
/**
 获取一段字符串的宽度
 */
-(CGFloat)getWidthFromfont:(CGFloat)font;

/**
 获取一段字符串的宽度
 */
- (CGFloat)getWidthWithSize:(CGSize)size andFont:(UIFont *)font;

/**
 获取一段字符串的高度
 */
- (CGFloat)getHeightWithSize:(CGSize)size andFont:(UIFont *)font;

/**
 获取一段字符串的size
 */
- (CGSize)getSizeWithSize:(CGSize)size andFont:(UIFont *)font;

/**
 移除首尾换行符
 */
- (NSString *)removeFirstAndLastLineBreak;

/**
 从html string获取图片url 数组
 */
- (NSArray *)getImageurlFromHtmlString;

/**
 普通字符串转换为十六进制
 */
- (NSString*)hexString;
/**
 出现类似这样格式的字段"\\U6df1\\U5733\\U56fd\\U5f00\\U884c01\\U673a\\U623",通常为Unicode码,转换函数为
 */
- (NSString *)replaceUnicode;

/**
 身份证号码格式化 6-4-4-4格式
 */
- (NSString *)idCardFormat;
/**
 银行卡格式化
 */
- (NSString *)creditCardFormat;

/**
 对字符串进行URL编码
 */
- (NSString *)encode;
/**
 对字符串进行URL解码
 */
- (NSString *)decode;


@end
