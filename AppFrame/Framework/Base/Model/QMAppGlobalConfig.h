//
//  QMAppGlobalConfig.h
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    QMAppDevelopEnvironment,
    QMAppTestEnvironment,
    QMAppProductEnvironment,
} QMAppEnvironment;

@interface QMAppGlobalConfig : NSObject

/** 默认开发环境 */
@property (nonatomic,assign,readonly) QMAppEnvironment enviroment;
/**
 应用当前支持的语言
 */
@property (nonatomic,strong,readonly) NSString *appLanguage;

+ (instancetype) sharedInstance;

/// 当前是否为开发环境
+ (BOOL)currentIsProductEnvironment;

/// 设置当前环境
- (void)setCurrentEnviroment:(QMAppEnvironment)enviroment;
/**
 设置app当前语言
 */
- (void)setAppCurrentLanguage:(NSString *)language;

/**
 设置应用支持语言,数组第一个为默认语言
 */
- (void)setAppSupportLanguage:(NSArray <NSString *>*)languageArr;

@end

NS_ASSUME_NONNULL_END
