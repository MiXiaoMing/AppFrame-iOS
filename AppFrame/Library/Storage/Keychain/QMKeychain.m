//
//  QMKeychain.m
//  AFNetworking
//

#import "QMKeychain.h"

@implementation QMKeychain
- (void)setPasswordObject:(id<NSCoding>)object {
    self.passwordData = [NSKeyedArchiver archivedDataWithRootObject:object];
}


- (id<NSCoding>)passwordObject {
    if ([self.passwordData length]) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:self.passwordData];
    }
    return nil;
}


- (void)setPassword:(NSString *)password {
    self.passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
}


- (NSString *)password {
    if ([self.passwordData length]) {
        return [[NSString alloc] initWithData:self.passwordData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

#pragma mark - Public

- (BOOL)save:(NSError *__autoreleasing *)error {
    OSStatus status = JXKeychainErrorBadArguments;
    if (!self.service || !self.account || !self.passwordData) {
        if (error) {
            *error = [[self class] errorWithCode:status];
        }
        return NO;
    }
    NSMutableDictionary *query = nil;
    NSMutableDictionary * searchQuery = [self query];
    status = SecItemCopyMatching((__bridge CFDictionaryRef)searchQuery, nil);
    if (status == errSecSuccess) {
        
        query = [[NSMutableDictionary alloc]init];
        [query setObject:self.passwordData forKey:(__bridge id)kSecValueData];
        status = SecItemUpdate((__bridge CFDictionaryRef)(searchQuery), (__bridge CFDictionaryRef)(query));
        
    }else if(status == errSecItemNotFound){
        
        query = [self query];
        [query setObject:self.passwordData forKey:(__bridge id)kSecValueData];
        status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
        
    }
    if (status != errSecSuccess && error != NULL) {
        *error = [[self class] errorWithCode:status];
    }
    return (status == errSecSuccess);
}

- (BOOL)deleteItem:(NSError *__autoreleasing *)error {
    OSStatus status = JXKeychainErrorBadArguments;
    if (!self.service || !self.account) {
        if (error) {
            *error = [[self class] errorWithCode:status];
        }
        return NO;
    }
    
    NSMutableDictionary *query = [self query];
    status = SecItemDelete((__bridge CFDictionaryRef)query);
    
    if (status != errSecSuccess && error != NULL) {
        *error = [[self class] errorWithCode:status];
    }
    
    return (status == errSecSuccess);
}

- (nullable NSArray *)fetchAll:(NSError *__autoreleasing *)error {
    NSMutableDictionary *query = [self query];
    [query setObject:@YES forKey:(__bridge id)kSecReturnAttributes];
    [query setObject:(__bridge id)kSecMatchLimitAll forKey:(__bridge id)kSecMatchLimit];
    
    CFTypeRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    if (status != errSecSuccess && error != NULL) {
        *error = [[self class] errorWithCode:status];
        return nil;
    }
    
    return (__bridge_transfer NSArray *)result;
}

- (BOOL)fetch:(NSError *__autoreleasing *)error {
    OSStatus status = JXKeychainErrorBadArguments;
    if (!self.service || !self.account) {
        if (error) {
            *error = [[self class] errorWithCode:status];
        }
        return NO;
    }
    
    CFTypeRef result = NULL;
    NSMutableDictionary *query = [self query];
    [query setObject:@YES forKey:(__bridge id)kSecReturnData];
    [query setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    
    if (status != errSecSuccess) {
        if (error) {
            *error = [[self class] errorWithCode:status];
        }
        return NO;
    }
    
    self.passwordData = (__bridge_transfer NSData *)result;
    return YES;
}


#pragma mark - Synchronization Status

#ifdef JXKEYCHAIN_SYNCHRONIZATION_AVAILABLE
+ (BOOL)isSynchronizationAvailable
{
    return floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1;
}
#endif

#pragma mark - Private
- (NSMutableDictionary *)query {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:4];
    [dictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    if (self.service) {
        [dictionary setObject:self.service forKey:(__bridge id)kSecAttrService];
    }
    
    if (self.account) {
        [dictionary setObject:self.account forKey:(__bridge id)kSecAttrAccount];
    }
    if (self.kSecAttrAccessible) {
        [dictionary setObject:(__bridge id)self.kSecAttrAccessible forKey:(__bridge id)kSecAttrAccessible];
    }
#if !TARGET_IPHONE_SIMULATOR
    if (self.accessGroup) {
        [dictionary setObject:self.accessGroup forKey:(__bridge id)kSecAttrAccessGroup];
    }
#endif
    
#ifdef JXKEYCHAIN_SYNCHRONIZATION_AVAILABLE
    if ([[self class] isSynchronizationAvailable]) {
        id value;
        switch (self.synchronizationMode) {
            case JXKeychainQuerySynchronizationModeNo: {
                value = @NO;
                break;
            }
            case JXKeychainQuerySynchronizationModeYes: {
                value = @YES;
                break;
            }
            case JXKeychainQuerySynchronizationModeAny: {
                value = (__bridge id)(kSecAttrSynchronizableAny);
                break;
            }
        }
        [dictionary setObject:value forKey:(__bridge id)(kSecAttrSynchronizable)];
    }
#endif
    return dictionary;
}

+ (NSError *)errorWithCode:(OSStatus) code {
    
    NSString *message = nil;
    switch (code) {
        case errSecSuccess: return nil;
        case JXKeychainErrorBadArguments:
            message = @"Some of the arguments were invalid";
            break;
        case errSecUnimplemented: {
            message = @"Function or operation not implemented";
            break;
        }
        case errSecParam: {
            message = @"One or more parameters passed to a function were not valid";
            break;
        }
        case errSecAllocate: {
            message = @"Failed to allocate memory";
            break;
        }
        case errSecNotAvailable: {
            message = @"No keychain is available. You may need to restart your computer";
            break;
        }
        case errSecDuplicateItem: {
            message = @"The specified item already exists in the keychain";
            break;
        }
        case errSecItemNotFound: {
            message = @"The specified item could not be found in the keychain";
            break;
        }
        case errSecInteractionNotAllowed: {
            message = @"User interaction is not allowed";
            break;
        }
        case errSecDecode: {
            message = @"Unable to decode the provided data";
            break;
        }
        case errSecAuthFailed: {
            message = @"The user name or passphrase you entered is not correct";
            break;
        }
        default: {
            
        }
    }
    NSDictionary *userInfo = nil;
    if (message) {
        userInfo = @{ NSLocalizedDescriptionKey : message };
    }
    return [NSError errorWithDomain:@"com.barnett.JXKeychainSimple" code:code userInfo:userInfo];
}
@end
