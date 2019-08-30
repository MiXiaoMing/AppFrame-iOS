//
//  QMKeychainTool.h
//  AFNetworking
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMKeychainTool : NSObject
/**
 保存密码字符串信息
 */
+ (BOOL)savePassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error;
/**
 删除密码信息
 */
+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error;
/**
 获取密码数据
 */
+ (nullable NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
