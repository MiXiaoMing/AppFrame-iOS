//
//  QMKeychain.h
//  AFNetworking
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

#if __IPHONE_7_0 || __MAC_10_9
#define JXKEYCHAIN_SYNCHRONIZATION_AVAILABLE 1
#endif

#ifdef JXKEYCHAIN_SYNCHRONIZATION_AVAILABLE
typedef NS_ENUM(NSUInteger, JXKeychainQuerySynchronizationMode) {
    JXKeychainQuerySynchronizationModeAny,
    JXKeychainQuerySynchronizationModeNo,
    JXKeychainQuerySynchronizationModeYes
};
#endif

typedef NS_ENUM(OSStatus, JXKeychainErrorCode) {
    JXKeychainErrorBadArguments = -1001,
};
NS_ASSUME_NONNULL_BEGIN

@interface QMKeychain : NSObject

@property (nonatomic, copy, nullable) NSString *account;

@property (nonatomic, copy, nullable) NSString *service;

@property (nonatomic, copy, nullable) NSString *accessGroup;

#ifdef JXKEYCHAIN_SYNCHRONIZATION_AVAILABLE

@property (nonatomic) JXKeychainQuerySynchronizationMode synchronizationMode;
#endif

@property (nonatomic) CFStringRef kSecAttrAccessible;

@property (nonatomic, copy, nullable) NSData *passwordData;

@property (nonatomic, copy, nullable) id<NSCoding> passwordObject;

@property (nonatomic, copy, nullable) NSString *password;

/**
 存储
 */
- (BOOL)save:(NSError **)error;

/**
 删除
 */
- (BOOL)deleteItem:(NSError **)error;

/**
 检索account
 */
- (nullable NSArray<NSDictionary<NSString *, id> *> *)fetchAll:(NSError **)error;

/**
 检索password
 */
- (BOOL)fetch:(NSError **)error;

#ifdef JXKEYCHAIN_SYNCHRONIZATION_AVAILABLE

+ (BOOL)isSynchronizationAvailable;
#endif

@end

NS_ASSUME_NONNULL_END
