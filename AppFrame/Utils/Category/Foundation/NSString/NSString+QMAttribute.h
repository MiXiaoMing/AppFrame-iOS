//
//  NSString+QMAttribute.h
//  AFNetworking
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (QMAttribute)

/**
 一段字符串添加关键字属性
 */
- (NSMutableAttributedString *)addAttributedWithKeyWord:(NSArray *)keyWordArr attributedDic:(NSDictionary<NSAttributedStringKey, id> *)attributedDic;

@end

NS_ASSUME_NONNULL_END
