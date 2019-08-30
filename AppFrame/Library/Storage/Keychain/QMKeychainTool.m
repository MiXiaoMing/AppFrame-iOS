//
//  QMKeychainTool.m
//  AFNetworking
//

#import "QMKeychainTool.h"
#import "QMKeychain.h"

@implementation QMKeychainTool

+ (BOOL)savePassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error
{
    QMKeychain *query = [[QMKeychain alloc] init];
    query.service = serviceName;
    query.account = account;
    query.password = password;
    return [query save:error];
}
+ (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error
{
    QMKeychain *query = [[QMKeychain alloc] init];
    query.service = serviceName;
    query.account = account;
    return [query deleteItem:error];
}

+ (nullable NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account error:(NSError **)error
{
    QMKeychain *query = [[QMKeychain alloc] init];
    query.service = serviceName;
    query.account = account;
    [query fetch:error];
    return query.password;
}
@end
