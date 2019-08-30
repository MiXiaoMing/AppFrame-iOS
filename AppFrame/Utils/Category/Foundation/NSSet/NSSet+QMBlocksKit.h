//
//  NSSet+QMBlocksKit.h
//  AppFrame
//
//  Created by edz on 2019/7/31.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSet (QMBlocksKit)

/**
 循环遍历
 */
- (void)bk_each:(void (^)(id obj))block;
/**
 并发循环遍历
 */
- (void)bk_apply:(void (^)(id obj))block;
/**
 返回集合中匹配的第一个对象
 */
- (id)bk_match:(BOOL (^)(id obj))block;
/**
 返回集合中匹配的所有对象
 */
- (NSSet *)bk_select:(BOOL (^)(id obj))block;
/**
 返回集合中不匹配的所有对象
 */
- (NSSet *)bk_reject:(BOOL (^)(id obj))block;
/**
 返回一个新集合
 */
- (NSSet *)bk_map:(id (^)(id obj))block;
/**
 累积遍历对象
 
 @param initial 初始参数（任意类型）
 */
- (id)bk_reduce:(id)initial withBlock:(id (^)(id sum, id obj))block;
/**
 集合中某个数据是否符合某个条件
 */
- (BOOL)bk_any:(BOOL (^)(id obj))block;
/**
 集合中某个数据是否不符合某个条件
 */
- (BOOL)bk_none:(BOOL (^)(id obj))block;
/**
 集合中是否所有对象都匹配
 */
- (BOOL)bk_all:(BOOL (^)(id obj))block;

@end

NS_ASSUME_NONNULL_END
