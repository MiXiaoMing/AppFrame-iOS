//
//  UIDevice+QM.h
//  AppFrame
//
//  Created by edz on 2019/7/31.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (QM)

/**
 获取通用 - 关于本机 - 名称
 */
+ (NSString *)getDeviceUserName;
/**
 获取设备类型
 
 @return iPhone/iTouch/iPad
 */
+ (NSString *)getDeviceModel;
/**
 获取系统名称
 */
+ (NSString *)getDeviceSystemName;
/**
 获取设备系统版本
 */
+ (NSString *)getDeviceSystemVersion;

/**
 获取设备电量
 */
+ (CGFloat)getDeviceBattery;

/**
 获取当前连接的WifiName
 */
+ (NSString *)getWifiName;
/**
 获取当前连接 WiFi的ip地址
 */
+ (NSString *)getIPAddress;
/**
 获取手机本地语言
 */
+ (NSString *)getCurrentLocalLanguage;

/**
 获取 WiFi 信号强度
 */
+ (NSInteger)getSignalStrength;
//获取IDFA
+ (NSString *)getIDFA;

//获取IDFV
+ (NSString *)getIDFV;

//获取UUID
+ (NSString *)getUUID;

//获得设备型号
+ (NSString *)getCurrentDeviceModel;

//获得设备名称
+ (NSString *)getCurrentDeviceName;
//获取设备的物理ip地址
+ (NSString *)getIpAddresses;
@end
