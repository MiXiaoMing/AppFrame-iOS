//
//  NSString+QMVerification.h
//  Module
//
//  Created by edz on 2019/7/30.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QMVerification)

#pragma mark - 实例方法
/**
 字符串是否为空
 */
- (BOOL)isNull;
/**
 是否为有效邮箱
 */
- (BOOL)isValidateEmail;
/**
 手机号码验证
 */
- (BOOL)isValidateMobile;
/**
 身份证号码验证
 */
- (BOOL)isValidateIdentityCard;
/**
 QQ号码验证
 */
- (BOOL)isValidateQQ;
/**
 微信号码验证
 */
- (BOOL)isValidateWechat;
/**
 输入是否合法（个性签名，组织姓名，组织名称）
 */
-(BOOL)isInputLegal;

#pragma mark - 其他
/**
 纯汉字数字验证
 */
- (BOOL)isValidateHanNumChar;
/**
 是否不含表情符号验证
 */
- (BOOL)isValidateNOEmoji;
/**
 纯字母数字验证
 */
- (BOOL)isValidateNumChar;
/**
 字符串是否为汉字，字母，数字和下划线组成
 */
- (BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore;
/**
 字符串是否包含表情
 */
- (BOOL)isContainsEmoji;
//正则判断数字
- (BOOL)isNumber;
//正整数+0
- (BOOL)isCountNumber;

@end
