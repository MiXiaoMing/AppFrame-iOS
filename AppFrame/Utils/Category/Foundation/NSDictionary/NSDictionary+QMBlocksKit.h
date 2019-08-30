//
//  NSDictionary+QMBlocksKit.h
//  Module
//
//  Created by edz on 2019/7/31.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (QMBlocksKit)

/**
 循环遍历字典
 */
- (void)bk_each:(void (^)(id key, id obj))block;
/**
 遍历执行block会分配在多核cpu上执行
 */
- (void)bk_apply:(void (^)(id key, id obj))block;
/**
 循环遍历字典以查找与块匹配的第一个键/值对。
 */
- (id)bk_match:(BOOL (^)(id key, id obj))block;
/**
 循环遍历字典以查找与块匹配的键/值对。
 */
- (NSDictionary *)bk_select:(BOOL (^)(id key, id obj))block;
/**
 循环遍历字典以查找与块不匹配的键/值对。
 */
- (NSDictionary *)bk_reject:(BOOL (^)(id key, id obj))block;
/**
 返回一个新的字典，block传入参数位置与原数组参数位置一一对应
 */
- (NSDictionary *)bk_map:(id (^)(id key, id obj))block;
/**
 循环遍历字典以查找是否有任何键/值对与块匹配。
 */
- (BOOL)bk_any:(BOOL (^)(id key, id obj))block;
/**
 循环遍历字典以查找是否没有键/值对与块匹配。
 */
- (BOOL)bk_none:(BOOL (^)(id key, id obj))block;

/**
 循环遍历字典以查找是否所有键/值对都与块匹配。
 */
- (BOOL)bk_all:(BOOL (^)(id key, id obj))block;

@end
