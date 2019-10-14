//
//  NSDate+QMConversion.m
//  AppFrame
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSDate+QMConversion.h"

@implementation NSDate (QMConversion)

+ (NSString *)stringWithTimestamp:(UInt64)tt format:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:tt];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

@end
