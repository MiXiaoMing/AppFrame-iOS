//
//  NSDictionary+QM.h
//  Module
//

#import <Foundation/Foundation.h>

@interface NSDictionary (QM)

#pragma mark - 实例方法

/**
 替换字典中的NSNull为空字符串
 */
- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;
/**
 字典非空判断
 */
- (BOOL)isBlankDictionary;

@end
