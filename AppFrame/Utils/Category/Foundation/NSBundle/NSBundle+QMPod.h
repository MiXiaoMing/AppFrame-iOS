//
//  NSBundle+QMPod.h
//  AppFrame
//
//  Created by edz on 2019/9/2.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (QMPod)

/**
 获取资源路径
 */
+ (NSString *)getPodResourcePathWith:(Class)cla fileName:(NSString *)fileName;

/**
 获取某个podName对象的bundle对象
 */
+ (NSBundle *)bundleWithPodName:(NSString *)podName;

/**
 根据key获取本地化对应的value
 */
+ (NSString *)localizedStringForKey:(NSString *)key language:(NSString *)language podName:(nullable NSString *)podName;
+ (UIImage *)getPodImageWith:(nullable NSString *)podName fileName:(NSString *)fileName type:(NSString *)type;
+ (NSString *)pathWithFileName:(NSString *)fileName podName:(NSString *)podName ofType:(NSString *)ext;

@end

NS_ASSUME_NONNULL_END
