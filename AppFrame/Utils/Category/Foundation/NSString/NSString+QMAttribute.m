//
//  NSString+QMAttribute.m
//  AFNetworking
//

#import "NSString+QMAttribute.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+QMVerification.h"

@implementation NSString (QMAttribute)

- (NSMutableAttributedString *)addAttributedWithKeyWord:(NSArray *)keyWordArr attributedDic:(NSDictionary<NSAttributedStringKey, id> *)attributedDic
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self];
    
    if (keyWordArr.count == 0) {
        return attributeString;
    }
    
    for (NSString *keyWord in keyWordArr) {
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:[NSString stringWithFormat:@"%@",keyWord] options:NSRegularExpressionCaseInsensitive error:nil];
        
        [regex enumerateMatchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, [self length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            [attributeString setAttributes:attributedDic range:result.range];
        }];
    }
    return attributeString;
}

+ (void)setSubStrColorWithFromStr:(NSString *)fromStr endStr:(NSString *)endStr label:(UILabel *)label color:(UIColor *)color font:(UIFont *)font
{
    
    if (label.text.length != 0 && [label.text rangeOfString:fromStr].location != NSNotFound && [label.text rangeOfString:endStr].location != NSNotFound) {
        
        NSString *labelText = label.text;
        NSMutableAttributedString *textAttributed = [[NSMutableAttributedString alloc] initWithString:labelText];

        NSRange range0 = {0,0};
        NSRange range1 = {0,0};
        for (NSInteger index = 0; index < [labelText length]; index++) {
            NSString *str = [labelText substringWithRange:NSMakeRange(index, 1)];
            
            if ([str isEqualToString:fromStr]) {
                range0 = NSMakeRange(index,1);//[labelText rangeOfString:fromStr];
            }
            if ([str isEqualToString:endStr]) {
                range1 = NSMakeRange(index,1);//[labelText rangeOfString:endStr];
            }
            if (range0.length > 0 && range1.length > 0) {
                [textAttributed addAttribute:NSFontAttributeName value:font range:NSMakeRange(range0.location, range1.location-range0.location+1)];
                [textAttributed addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range0.location, range1.location-range0.location+1)];
                range0 = NSMakeRange(0,0);
                range1 = NSMakeRange(0,0);
            }
            
            
        }
        
        label.attributedText = textAttributed;
        
    }
}

+ (void)setSubNumStrColorWithLabel:(UILabel *)label color:(UIColor *)color font:(UIFont *)font
{
    if (label.text.length != 0) {
        NSString *labelText = label.text;
        NSMutableAttributedString *textAttributed = [[NSMutableAttributedString alloc] initWithString:labelText];
        
        //处理数字数据变颜色
        NSRange range0 = {0,0};
        for (NSInteger index = 0; index < [labelText length]; index++) {
            NSString *str = [labelText substringWithRange:NSMakeRange(index, 1)];
            
            if ([str isNumber] || [str isEqualToString:@"."]) {
                range0 = NSMakeRange(index,1);
            }
            if (range0.length > 0) {
                [textAttributed addAttribute:NSFontAttributeName value:font range:NSMakeRange(range0.location, range0.length)];
                [textAttributed addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range0.location, range0.length)];
                range0 = NSMakeRange(0,0);
            }
        }
        label.attributedText = textAttributed;
    }
    
}
+ (void)setSubStringWithLabel:(UILabel *)label textArray:(NSArray *)textArray font:(UIFont *)font color:(UIColor *)color;
{
    NSMutableAttributedString *textAttributed = [[NSMutableAttributedString alloc] initWithString:label.text];
    for (NSString *markStr in textArray) {
        if (label.text.length != 0 && [label.text rangeOfString:markStr].location != NSNotFound) {
            NSRange range=[label.text rangeOfString:markStr];
            [textAttributed addAttribute:NSFontAttributeName value:font range:NSMakeRange(range.location, markStr.length)];
            [textAttributed addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range.location, markStr.length)];
        }
    }
    label.attributedText = textAttributed;
}

+ (void)setSubStrColorWithBecomeStr:(NSString *)becomeStr endStr:(NSString *)endStr label:(UILabel *)label color:(UIColor *)color
{
    NSString *labelText = label.text;
    if (label.text.length != 0 && [label.text rangeOfString:becomeStr].location != NSNotFound) {
        NSRange range0 = [labelText rangeOfString:becomeStr];
        NSRange range1 = [labelText rangeOfString:endStr];
        NSMutableAttributedString *textAttributed = [[NSMutableAttributedString alloc] initWithString:labelText];
        //    [textAttributed addAttribute:NSFontAttributeName value:GetFont(14.0f) range:NSMakeRange(0, betMoneyText.length)];
        //    [textAttributed addAttribute:NSForegroundColorAttributeName value:ColorSubTitle range:NSMakeRange(0, betMoneyText.length)];
        [textAttributed addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range0.location+1, range1.location-range0.location-1)];
        label.attributedText = textAttributed;
    }
    
}

+ (void)setSubStrColorFromBecomeStr:(NSString *)becomeStr label:(UILabel *)label color:(UIColor *)color font:(UIFont *)font
{
    if (label.text.length != 0 && [label.text rangeOfString:becomeStr].location != NSNotFound) {
        NSRange range=[label.text rangeOfString:becomeStr];
        NSMutableAttributedString *textAttributed = [[NSMutableAttributedString alloc] initWithString:label.text];
        [textAttributed addAttribute:NSFontAttributeName value:font range:NSMakeRange(range.location+1, label.text.length - (range.location+1))];
        [textAttributed addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range.location+1, label.text.length - (range.location+1))];
        label.attributedText = textAttributed;
    }
}

@end
