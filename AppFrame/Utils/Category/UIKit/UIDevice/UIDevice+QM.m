//
//  UIDevice+QM.m
//  AppFrame
//
//  Created by edz on 2019/7/31.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "UIDevice+QM.h"

#import <sys/utsname.h>

#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

#import <AdSupport/ASIdentifierManager.h>

@implementation UIDevice (QM)
+ (NSString *)getDeviceUserName
{
    UIDevice *dev = [self currentDevice];
    return dev.name;
}

+ (NSString *)getDeviceModel
{
    UIDevice *dev = [self currentDevice];
    return dev.model;
}

+ (NSString *)getDeviceSystemName
{
    UIDevice *dev = [self currentDevice];
    return dev.systemName;
}

+ (NSString *)getDeviceSystemVersion
{
    UIDevice *dev = [self currentDevice];
    
    return dev.systemVersion;
}

+ (CGFloat)getDeviceBattery
{
    CGFloat batteryLevel=[[UIDevice currentDevice] batteryLevel];
    return batteryLevel;
}

+ (NSString *)getWifiName {
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            //            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+ (NSString *)getCurrentLocalLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}

+ (NSInteger)getSignalStrength{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSString *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    NSInteger signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] integerValue];
    
    return signalStrength;
}

+ (NSString *)getIDFA
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)getIDFV
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (NSString *)getUUID
{
    return [[NSUUID UUID] UUIDString];
}
+ (BOOL)isIphoneX
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"x86_64"]) {
        NSProcessInfo *processInfo = [[NSProcessInfo alloc] init];
        platform = [processInfo.environment objectForKey:@"SIMULATOR_MODEL_IDENTIFIER"];
    }
    NSArray *arr = [platform componentsSeparatedByString:@","];
    NSString *deviceStr = [arr firstObject];
    NSString *typeStr = [arr lastObject];
    if ([deviceStr containsString:@"iPhone"]) {
        deviceStr = [deviceStr stringByReplacingOccurrencesOfString:@"iPhone" withString:@""];
        if ([deviceStr intValue] > 10 || ([deviceStr isEqualToString:@"10"] && ([typeStr isEqualToString:@"3"] || [typeStr isEqualToString:@"6"]))) {
            return true;
        }else
        {
            return false;
        }
    }else
    {
        return false;
    }
}

+ (BOOL)isIphone5
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"x86_64"]) {
        NSProcessInfo *processInfo = [[NSProcessInfo alloc] init];
        platform = [processInfo.environment objectForKey:@"SIMULATOR_MODEL_IDENTIFIER"];
    }
    if ([platform containsString:@"iPhone5"] || [platform containsString: @"iPhone6"] || [platform isEqualToString:@"iPhone8,4"]) {
        return YES;
    }else
    {
        return NO;
    }
}
@end
