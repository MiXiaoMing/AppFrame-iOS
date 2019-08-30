//
//  NSError+QM.h
//  AppFrame
//

#import <Foundation/Foundation.h>

@interface NSError (QM)

#pragma mark - 类方法
/**
 * @brief 构造Error
 *
 * @param code 错误代码
 * @param errorMsg 错误信息
 *
 * @return 返回错误对象.
 */
+ (NSError *)errorWithCode:(NSInteger)code errorMessage:(NSString*)errorMsg;

#pragma mark - 实例方法
/**
 * @brief 返回相关错误码
 * @return 错误码
 */
- (NSInteger)errorCode;

/**
 * @brief 错误信息
 * @return 错误信息
 */
- (NSString*)errorMsg;

@end
