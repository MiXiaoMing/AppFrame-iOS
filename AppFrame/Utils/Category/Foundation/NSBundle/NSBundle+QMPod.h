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

+ (UIImage *)getPodImageWith:(Class)cla fileName:(NSString *)fileName type:(NSString *)type;

/**
 获取某个podName对象的bundle对象
 */
+ (NSBundle *)bundleWithPodName:(NSString *)podName;

/**
 根据key获取本地化对应的value
 */
+ (NSString *)localizedStringForKey:(NSString *)key language:(NSString *)language podName:(NSString *)podName;

@end

NS_ASSUME_NONNULL_END
