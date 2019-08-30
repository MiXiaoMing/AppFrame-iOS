//
//  NSArray+QM.m
//  AppFrame
//

#import "NSArray+QM.h"
#import "NSObject+QM.h"
#import <objc/runtime.h>

@interface NSDictionary (QM)
- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;

@end
@implementation NSDictionary (QM)

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks {
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        id object = [self objectForKey:key];
        if (object == nul) [replaced setObject:blank forKey:key];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setObject:[object dictionaryByReplacingNullsWithBlanks] forKey:key];
        else if ([object isKindOfClass:[NSArray class]])
            [replaced setObject:[object arrayByReplacingNullsWithBlanks] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}
@end

@implementation NSArray (QM)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzleClassInstanceMethodWithOriginSel:@selector(objectAtIndex:) swizzleSel:@selector(qm_objectAtIndex:)];
    });
}

- (id)qm_objectAtIndex:(NSUInteger)index {
    if (self.count-1 < index || self.count == 0) {
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            return [self qm_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            //            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            //            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } else {
        return [self qm_objectAtIndex:index];
    }
}

- (NSArray *)filterTheSameElement
{
    NSMutableSet *set = [NSMutableSet set];
    for (NSObject *obj in self) {
        [set addObject:obj];
    }
    
    NSMutableArray *newArr = [NSMutableArray array];
    for (NSObject *obj in set) {
        [newArr addObject:obj];
    }
    return (NSArray *)newArr;
}

/**
 数组非空判断
 */
- (BOOL)isBlankArr
{
    if (!self) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (![self isKindOfClass:[NSArray class]]) {
        return YES;
    }
    if (!self.count) {
        return YES;
    }
    if (self==nil) {
        return YES;
    }
    if (self == NULL) {
        return YES;
    }
    return NO;
    
}

- (NSArray *)arrayByReplacingNullsWithBlanks  {
    NSMutableArray *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[object dictionaryByReplacingNullsWithBlanks]];
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[object arrayByReplacingNullsWithBlanks]];
    }
    return [replaced copy];
}
@end
