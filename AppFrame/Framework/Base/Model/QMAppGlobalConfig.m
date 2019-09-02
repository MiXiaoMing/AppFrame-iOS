//
//  QMAppGlobalConfig.m
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "QMAppGlobalConfig.h"

#define QMAppLanguage @"QMAppLanguage"

@interface QMAppGlobalConfig ()

@property (nonatomic,assign,readwrite) QMAppEnvironment enviroment;
@property (nonatomic,strong,readwrite) NSString *appLanguage;
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
        NSArray *lanArr = @[@"en",@"zh-Hans"];
        [[NSUserDefaults standardUserDefaults] setObject:lanArr forKey:QMAppLanguage];
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
    _enviroment = enviroment;
}
-(QMAppEnvironment)enviroment
{
    return _enviroment;
}


- (void)setAppCurrentLanguage:(NSString *)language
{
    if ([_appLanguage isEqualToString:language]) {
        return;
    }
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:QMAppLanguage];
    if ([arr containsObject:language]) {
        _appLanguage = language;
    }else
    {
        _appLanguage = arr.firstObject;
    }
}

- (void)setAppSupportLanguage:(NSArray <NSString *>*)languageArr
{
    [[NSUserDefaults standardUserDefaults] setObject:languageArr forKey:QMAppLanguage];
}

- (NSString *)appLanguage
{
    if (_appLanguage) {
        return _appLanguage;
    }else
    {
        NSString * languageName = languageName = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] firstObject];
        NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:QMAppLanguage];
        if ([arr containsObject:languageName]) {
            _appLanguage = languageName;
        }else
        {
            _appLanguage = arr.firstObject;
        }
        return _appLanguage;
    }
}

@end
