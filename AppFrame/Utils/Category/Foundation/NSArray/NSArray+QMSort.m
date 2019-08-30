//
//  NSArray+QMSort.m
//  Module
//

#import "NSArray+QMSort.h"

@implementation NSArray (QMSort)

+ (void)quickSort:(NSMutableArray <NSDictionary *>*)array low:(NSInteger)low high:(NSInteger)high key:(NSString *)key
{
    if(array == nil || array.count == 0){
        return;
    }
    if (low >= high) {
        return;
    }
    
    NSInteger middle = low + (high - low)/2;
    NSString *prmt = array[middle][key];
    NSInteger i = low;
    NSInteger j = high;
    while (i <= j) {
        while ([array[i][key] intValue] > [prmt intValue]) {
            i++;
        }
        while ([array[j][key] intValue] < [prmt intValue]) {
            j--;
        }
        
        if(i <= j){
            [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
            j--;
        }
    }
    
    if (low < j) {
        [self quickSort:array low:low high:j key:key];
    }
    if (high > i) {
        [self quickSort:array low:i high:high key:key];
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
@end
