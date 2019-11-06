//
//  NSBundle+QM.m
//  AppFrame
//
//  Created by edz on 2019/11/6.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSBundle+QM.h"

@implementation NSBundle (QM)

#pragma mark - 获取应用名称
+ (NSString *)getApplicationName
{
    NSDictionary *infoDictionary = [[self mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleName"];
    return app_Name;
}

#pragma mark - 获取应用版本号
+ (NSString *)getApplicationVersion
{
    NSDictionary *infoDictionary = [[self mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}
#pragma mark - 获取BundleID
+ (NSString *)getBundleID
{
    return [[self mainBundle] bundleIdentifier];
}

+ (NSString *)getBuildVersion
{
    NSDictionary *infoDictionary = [[self mainBundle] infoDictionary];
    NSString *app_Build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_Build;
}

@end
