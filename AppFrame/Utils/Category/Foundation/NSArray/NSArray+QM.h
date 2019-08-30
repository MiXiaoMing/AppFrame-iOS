//
//  NSArray+QM.h
//  AppFrame
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (QM)
#pragma mark - 实例方法
/**
 过滤相同元素
 */
- (NSArray *)filterTheSameElement;

/**
 数组非空判断
 */
- (BOOL)isBlankArr;

/**
 替换数组中的NSNull为空字符串
 */
- (NSArray *)arrayByReplacingNullsWithBlanks;
@end

NS_ASSUME_NONNULL_END
