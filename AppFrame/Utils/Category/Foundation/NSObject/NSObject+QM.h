
//
//  NSObject+QM.h
//  Module
//

#import <Foundation/Foundation.h>


@interface NSObject (QM)

#pragma mark - 实例方法
/**
 返回类属性字典
 */
- (NSDictionary *)properties_aps;

/**
 是否为非空值
 */
- (BOOL)isNotEmpty;

/**
 swizzle类方法
 */
+ (void)swizzleClassMethodOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel;

/**
 swizzle类实例方法
 */
+ (void)swizzleClassInstanceMethodWithOriginSel:(SEL)oriSel swizzleSel:(SEL)swiSel;

@end
