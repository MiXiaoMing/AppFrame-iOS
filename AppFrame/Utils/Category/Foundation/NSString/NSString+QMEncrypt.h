//
//  NSString+QMEncrypt.h
//  Module
//
//  Created by edz on 2019/7/30.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QMEncrypt)

/**
 MD5加密
 */
- (NSString *)MD5Encrypt;

/**
 base64编码
 */
- (NSString *)encodeWithBase64;
/**
 base64解码
 */
- (NSString *)decodeWithBase64;

/**
 AES128 加密
 
 @param key 秘钥
 */
- (NSString *)encryptWithAES128_Key:(NSString *)key keyIv:(NSString *)keyIv;
/**
 AES128 解密
 
 @param key 秘钥
 */
- (NSString *)decryptWithAES128_Key:(NSString *)key keyIv:(NSString *)keyIv;
@end
