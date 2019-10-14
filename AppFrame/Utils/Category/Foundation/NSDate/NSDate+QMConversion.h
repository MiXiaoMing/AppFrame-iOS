//
//  NSDate+QMConversion.h
//  AppFrame
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (QMConversion)

/**
 根据日期格式转化时间戳(UTC)
 */
+ (NSString *)stringWithTimestamp:(UInt64)tt format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
