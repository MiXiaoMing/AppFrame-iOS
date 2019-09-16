//
//  UIColor+QM.m
//  AppFrame
//
//  Created by edz on 2019/8/27.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "UIColor+QM.h"

@implementation UIColor (QM)
+ (UIColor *)colorFromRGBA:(int)RGBA
{
    CGFloat r= (RGBA & 0x00FF0000) >> 16 ;
    CGFloat g= (RGBA & 0x0000FF00) >> 8  ;
    CGFloat b= (RGBA & 0x000000FF) >> 0  ;
    CGFloat a= (RGBA & 0xFF000000) >> 24 ;
    
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}

+ (UIColor *)hexColorWithString:(NSString *)string
{
    return [UIColor hexColorWithString:string alpha:1.0f];
}

+ (UIColor *)hexColorWithString:(NSString *)string alpha:(float)alpha
{
    if ([string hasPrefix:@"#"]) {
        string = [string substringFromIndex:1];
    }
    
    NSString *pureHexString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([pureHexString length] != 6) {
        return [UIColor whiteColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [pureHexString substringWithRange:range];
    
    range.location += range.length ;
    NSString *gString = [pureHexString substringWithRange:range];
    
    range.location += range.length ;
    NSString *bString = [pureHexString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
@end
