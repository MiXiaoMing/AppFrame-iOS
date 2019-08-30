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


@end
