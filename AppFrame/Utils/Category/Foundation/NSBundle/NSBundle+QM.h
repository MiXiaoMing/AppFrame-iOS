//
//  NSBundle+QM.h
//  AppFrame
//
//  Created by edz on 2019/11/6.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (QM)

/**
 获取app应用名称
 */
+ (NSString *)getApplicationName;
/**
 获取 APP 应用版本
 */
+ (NSString *)getApplicationVersion;
/**
 获取BundleID
 */
+ (NSString *)getBundleID;
/**
 获取编译版本
 */
+ (NSString *)getBuildVersion;

@end

NS_ASSUME_NONNULL_END
