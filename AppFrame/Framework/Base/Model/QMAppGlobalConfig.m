//
//  QMAppGlobalConfig.m
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "QMAppGlobalConfig.h"

@interface QMAppGlobalConfig ()

@property (nonatomic,assign,readwrite) QMAppEnvironment enviroment;

@end

@implementation QMAppGlobalConfig

static QMAppGlobalConfig *sharedSingleton = nil;
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(sharedSingleton == nil)
        {
            sharedSingleton = [super allocWithZone:zone];
        }
    });
    return sharedSingleton;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.enviroment = QMAppDevelopEnvironment;
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(sharedSingleton == nil)
        {
            sharedSingleton = [[self alloc] init];
        }
    });
    return sharedSingleton;
}
- (id)copy
{
    return self;
}

- (id)mutableCopy
{
    return self;
}

- (void)setCurrentEnviroment:(QMAppEnvironment)enviroment
{
    self.enviroment = enviroment;
}


@end
