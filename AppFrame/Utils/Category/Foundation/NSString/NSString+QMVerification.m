//
//  NSString+QMVerification.m
//  Module
//
//  Created by edz on 2019/7/30.
//  Copyright © 2019 edz. All rights reserved.
//

#import "NSString+QMVerification.h"
#import <mach/mach_time.h>

@implementation NSString (QMVerification)
- (BOOL)isNull
{
    BOOL result = NO;
    
    if (![self isKindOfClass:[NSString class]] ){
        return  YES;
    }
    
    if (NULL == self || [self isEqual:nil] || [self isEqual:Nil])
    {
        result = YES;
    }
    else if ([self isEqual:[NSNull null]])
    {
        result = YES;
    }
    if([self isEqualToString:@"<null>"]){
        return  YES;
    }
    else if (0 == [self length] || 0 == [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
    {
        result = YES;
    }
    else if([self isEqualToString:@"(null)"])
    {
        result = YES;
    }
    
    return result;
}

- (BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
- (BOOL)isValidateMobile
{
    NSString *phoneRegex = @"^1(3[0-9]|4[6-9]|5[0-35-9]|6[6]|7[0-8]|8[0-9]|9[89])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:self];
}
- (BOOL)isValidateIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}
- (BOOL)isValidateQQ
{
    if (self.length == 0) {
        return NO;
    }
    NSString *regex = @"[1-9][0-9]{4,14}";//第一位1-9之间的数字，第二位0-9之间的数字，数字范围4-14个之间
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}
- (BOOL)isValidateWechat
{
    if (self.length == 0) {
        return NO;
    }
    NSString *regex = @"^[a-zA-Z][a-zA-Z0-9_-]{5,19}$";//第一位1-9之间的数字，第二位0-9之间的数字，数字范围4-14个之间
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}
-(BOOL)isInputLegal
{
    NSString *stringRegex01 = @"[\u4E00-\u9FA5a-zA-Z0-9\\@\\#\\$\\^\\&\\*\\(\\)\\-\\+\\.\\ \\_]*";
    NSString *stringRegex02 = @"[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*";
    NSPredicate *predicte01 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringRegex01];
    NSPredicate *predicte02 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringRegex02];
    return ([predicte01 evaluateWithObject:self]||[predicte02 evaluateWithObject:self])&&![self isContainsEmoji];
}
- (BOOL)isValidateHanNumChar
{
    if (self.length == 0) {
        return NO;
    }
    NSString *regex = @"^[a-zA-Z0-9\u4e00-\u9fa5]*$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
    
}
- (BOOL)isValidateNOEmoji
{
    if (self.length == 0) {
        return NO;
    }
    NSString *regex = @"^[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]*$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}
- (BOOL)isValidateNumChar
{
    if (self.length == 0) {
        return NO;
    }
    NSString *regex = @"^[a-zA-Z0-9]*$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}
- (BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore
{
    NSInteger len=self.length;
    for(NSInteger i=0;i<len;i++)
    {
        unichar a=[self characterAtIndex:i];
        if(!((isalpha(a))
             ||(isalnum(a))
             ||((a=='_'))
             ||((a >= 0x4e00 && a <= 0x9fa6))
             ))
            return NO;
    }
    return YES;
}
/**
 字符串是否包含表情
 */
- (BOOL)isContainsEmoji
{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if ((0x1d000 <= uc && uc <= 0x1f77f) || (0x1F900 <= uc && uc <=0x1f9ff)){
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }else if (hs == 0x200d){
                                      returnValue = YES;
                                  }
                              }
                          }];
    return returnValue;
}

- (BOOL)isNumber
{
    if (self.length == 0) {
        return NO;
    }
    NSString *regex = @"^[0-9]*$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}
@end
