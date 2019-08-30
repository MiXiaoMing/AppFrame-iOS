//
//  NSString+QMAttribute.m
//  AFNetworking
//

#import "NSString+QMAttribute.h"

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

@end
