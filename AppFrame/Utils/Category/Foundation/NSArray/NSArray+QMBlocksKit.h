//
//  NSArray+QMBlocksKit.h
//  Module
//
//  Created by edz on 2019/7/31.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

@interface NSArray (QMBlocksKit)
/**
 循环遍历数组
 */
- (void)bk_each:(void (^)(id obj))block;

/**
 遍历执行block会分配在多核cpu上执行
 */
- (void)bk_apply:(void (^)(id obj))block;

/**
 返回数组中匹配的第一个对象
 */
- (id)bk_match:(BOOL (^)(id obj))block;

/**
 返回数组中匹配的所有对象
 */
- (NSArray *)bk_select:(BOOL (^)(id obj))block;

/**
 返回数组中非指定的所有对象
 */
- (NSArray *)bk_reject:(BOOL (^)(id obj))block;

/**
 返回一个新的数组，block传入参数位置与原数组参数位置一一对应
 */
- (NSArray *)bk_map:(id (^)(id obj))block;

/**
 累积遍历对象
 
 @param initial 初始参数（任意类型）
 */
- (id)bk_reduce:(id)initial withBlock:(id (^)(id sum, id obj))block;
/**
 累积遍历 NSInteger
 
 @param initial 初始参数（NSInteger）
 */
- (NSInteger)bk_reduceInteger:(NSInteger)initial withBlock:(NSInteger(^)(NSInteger result, id obj))block;
/**
 累积遍历 CGFloat
 
 @param initial 初始参数（CGFloat）
 */
- (CGFloat)bk_reduceFloat:(CGFloat)initial withBlock:(CGFloat(^)(CGFloat result, id obj))block;

/**
 数组中某个数据是否符合某个条件
 */
- (BOOL)bk_any:(BOOL (^)(id obj))block;

/**
 数组中某个数据是否不符合某个条件
 */
- (BOOL)bk_none:(BOOL (^)(id obj))block;

/**
 循环遍历数组以查找是否所有对象都与块匹配。
 */
- (BOOL)bk_all:(BOOL (^)(id obj))block;

/**
 对比该数组和另一个数组中数据
 
 @param list 另一个数组
 */
- (BOOL)bk_corresponds:(NSArray *)list withBlock:(BOOL (^)(id obj1, id obj2))block;
@end
