//
//  FoundationGlobalHeader.h
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#ifndef FoundationGlobalHeader_h
#define FoundationGlobalHeader_h

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

#define QMWeakSelf(type)__weak typeof(type)weak##type = type;
#define QMStrongSelf(type)__strong typeof(type)type = weak##type;

// 有效值判断
#define StrValid(f)(f!=nil && f.length != 0 &&[f isKindOfClass:[NSString class]]&& ![f isEqualToString:@""])

#define SafeStr(f)(StrValid(f)?f:@"")

#define HasString(str,eky)([str rangeOfString:key].location!=NSNotFound)

#define ValidDict(f)(f!=nil && [f isKindOfClass:[NSDictionary class]] && dic.allKeys.count > 0)

#define ValidArray(f)(f!=nil && [f isKindOfClass:[NSArray class]]&&[f count]>0)

#define ValidNum(f)(f!=nil &&[f isKindOfClass:[NSNumber class]])

#define ValidClass(f,cls)(f!=nil &&[f isKindOfClass:[cls class]])

#define ValidData(f)(f!=nil &&[f isKindOfClass:[NSData class]])


#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)


#pragma mark - 单例化一个类
#define SYNTHESIZE_SINGLETON_FOR_CLASS_ARC(classname) \
\
static classname *default##classname = nil; \
\
+ (classname *)default##classname \
{ \
@synchronized(self) \
{ \
if (default##classname == nil) \
{ \
default##classname = [[[self class] alloc] init]; \
} \
} \
\
return default##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (default##classname == nil) \
{ \
default##classname = [super allocWithZone:zone]; \
return default##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}


#ifdef DEBUG

#define DLog(fmt,...) NSLog((@"%s[Line %d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__);
#define GLLog(...) printf("%s %s [%d]: %s\n",[[NSString timeString] UTF8String],[NSStringFromClass([self class]) UTF8String],__LINE__,[[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else

#define DLog(...)
#define GLLog(...)

#endif


#endif /* FoundationGlobalHeader_h */
