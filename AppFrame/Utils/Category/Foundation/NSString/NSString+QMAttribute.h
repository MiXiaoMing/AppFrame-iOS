//
//  NSString+QMAttribute.h
//  AFNetworking
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (QMAttribute)

/**
 一段字符串添加关键字属性
 */
- (NSMutableAttributedString *)addAttributedWithKeyWord:(NSArray *)keyWordArr attributedDic:(NSDictionary<NSAttributedStringKey, id> *)attributedDic;

/**
 *  修改给定文字之间的文本的颜色（包括给定文字）
 *
 *  @param fromStr 开始之前的文本
 *  @param endStr    结束之后的文本
 *  @param label     传入的label
 *  @param color     颜色
 *  @param font      字体大小
 */
+ (void)setSubStrColorWithFromStr:(NSString *)fromStr endStr:(NSString *)endStr label:(UILabel *)label color:(UIColor *)color font:(UIFont *)font;

/**
 *  处理数字数据变颜色,包括浮点数
 */
+ (void)setSubNumStrColorWithLabel:(UILabel *)label color:(UIColor *)color font:(UIFont *)font;

/**
 *  修改给定的字符串数组中的字符串的颜色
 *
 *  @param label                       传入的label
 *  @param textArray                   需要变色的字符串数组
 *  @param font                        修改后的字体
 *  @param color                       修改后的颜色
 */
+ (void)setSubStringWithLabel:(UILabel *)label textArray:(NSArray *)textArray font:(UIFont *)font color:(UIColor *)color;

/**
 *  修改给定文字之间的文本的颜色（不包括给定文字）
 *
 *  @param becomeStr 开始之前的文本
 *  @param endStr    结束之后的文本
 *  @param label     传入的label
 *  @param color     传入的颜色
 */
+ (void)setSubStrColorWithBecomeStr:(NSString *)becomeStr endStr:(NSString *)endStr label:(UILabel *)label color:(UIColor *)color;

/**
 *  修改给定文字之后的文本的颜色(不包括给定文字)
 *
 *  @param becomeStr 开始之前的文本
 *  @param label     传入的label
 *  @param color     传入的颜色
 *  @param font      传入的字体大小
 */
+ (void)setSubStrColorFromBecomeStr:(NSString *)becomeStr label:(UILabel *)label color:(UIColor *)color font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
