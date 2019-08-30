//
//  NSArray+QMSort.h
//  Module
//

#import <Foundation/Foundation.h>

@interface NSArray (QMSort)

#pragma mark - 类方法

/**
 快速排序
 */
+ (void)quickSort:(NSMutableArray <NSDictionary *>*)array low:(NSInteger)low high:(NSInteger)high key:(NSString *)key;


@end
