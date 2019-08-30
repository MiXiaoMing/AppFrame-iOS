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

+ (QMAppGlobalConfig *) sharedInstance;

- (void)setCurrentEnviroment:(QMAppEnvironment)enviroment;

@end

NS_ASSUME_NONNULL_END
