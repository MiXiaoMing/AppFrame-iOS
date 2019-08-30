//
//  NSString+QM.m
//  Module
//
//  Created by edz on 2019/7/30.
//  Copyright © 2019 edz. All rights reserved.
//

#import "NSString+QM.h"
#import <objc/runtime.h>
#import "NSObject+QM.h"
@implementation NSString (QM)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleClassInstanceMethodWithOriginSel:@selector(substringFromIndex:) swizzleSel:@selector(qm_substringFromIndex:)];
    });
}

- (id)qm_substringFromIndex:(NSUInteger)index {
    if (self.length-1 < index || self.length == 0) {
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            return [self qm_substringFromIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息，方便我们调试。
            //            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            //            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } else {
        return [self qm_substringFromIndex:index];
    }
}
-(CGFloat)getWidthFromfont:(CGFloat)font
{
    CGRect tagRect = [self boundingRectWithSize:CGSizeMake(10000, 20) options:NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] context:nil];
    return tagRect.size.width;
}

- (CGFloat)getWidthWithSize:(CGSize)size andFont:(UIFont *)font
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width;
}
- (CGFloat)getHeightWithSize:(CGSize)size andFont:(UIFont *)font
{
    return [self boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height;
}
- (CGSize)getSizeWithSize:(CGSize)size andFont:(UIFont *)font
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (NSString *)removeFirstAndLastLineBreak
{
    NSString *newStr = self;
    while ([newStr hasPrefix:@"\n"]) {
        newStr = [newStr substringFromIndex:2];
    }
    while ([newStr hasSuffix:@"\n"]) {
        newStr = [newStr substringToIndex:newStr.length-1];
    }
    return newStr;
}

- (NSArray *)getImageurlFromHtmlString
{
    NSMutableArray * imageurlArray = [NSMutableArray arrayWithCapacity:1];
    //标签匹配
    NSString *parten = @"<img(.*?)>";
    NSError* error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
    
    NSArray* match = [reg matchesInString:self options:0 range:NSMakeRange(0, [self length] - 1)];
    
    for (NSTextCheckingResult * result in match) {
        
        NSRange range = [result range];
        NSString * subString = [self substringWithRange:range];
        
        NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"http://(.*?)\"" options:0 error:NULL];
        NSArray* match = [subReg matchesInString:subString options:0 range:NSMakeRange(0, [subString length] - 1)];
        NSTextCheckingResult * subRes = match[0];
        NSRange subRange = [subRes range];
        subRange.length = subRange.length -1;
        NSString * imagekUrl = [subString substringWithRange:subRange];
        
        [imageurlArray addObject:imagekUrl];
    }
    return imageurlArray;
}

- (NSString*)hexString
{
    NSData *myD = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    NSString *hexStr=@"";
    for(int i = 0; i < [myD length]; i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i]&0xff];//16进制数
        
        if([newHexStr length]==1)
        {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else
        {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr;
}
- (NSString *)replaceUnicode
{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

- (NSString *)idCardFormat
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[self substringToIndex:6]];
    [array addObject:[self substringWithRange:NSMakeRange(6, 4)]];
    [array addObject:[self substringWithRange:NSMakeRange(10, 4)]];
    [array addObject:[self substringWithRange:NSMakeRange(14, 4)]];
    return [NSString stringWithFormat:@"%@ %@ %@ %@",array[0],array[1],array[2],array[3]];
}

- (NSString *)creditCardFormat
{
    NSString *newString = @"";
    NSString *originalCardNumber = self;
    while (originalCardNumber.length > 0) {
        NSString *subString = [originalCardNumber substringToIndex:MIN(originalCardNumber.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        originalCardNumber = [originalCardNumber substringFromIndex:MIN(originalCardNumber.length, 4)];
    }
    
    return newString;
}
- (NSString *)encode
{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedStr = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedStr;
}
- (NSString *)decode
{
    NSString *decodedStr = [self stringByRemovingPercentEncoding];
    return decodedStr;
}

@end
