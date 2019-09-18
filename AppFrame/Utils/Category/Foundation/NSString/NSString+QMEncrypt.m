//
//  NSString+QMEncrypt.m
//  Module
//
//  Created by edz on 2019/7/30.
//  Copyright © 2019 edz. All rights reserved.
//

#import "NSString+QMEncrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (QMEncrypt)

/**
 MD5加密
 */
- (NSString *)MD5Encrypt
{
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}
- (NSString *)encryptUseHMACMD5WithHmacKey:(NSString *)key
{
    //第1步------ MD5 ------
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    
    //第2步------ hmac ------
    
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    
    char cHMAC[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, cKey, strlen(cKey), result, sizeof(result), cHMAC);
    
    //第3步------ hexstring ------
    //下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", cHMAC[i]&0xff];//16进制数
        if([newHexStr length]==1)
        {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else
        {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    
    return hexStr;
}
- (NSString *)encodeWithBase64
{
    NSData *nsdata = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    return base64Encoded;
}

- (NSString *)decodeWithBase64
{
    NSData *nsdataFromBase64String = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *base64Decoded = [[NSString alloc] initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    return base64Decoded;
}

- (NSString *)encryptWithAES128_Key:(NSString *)key keyIv:(NSString *)keyIv
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *AESData = [self AES128operation:kCCEncrypt
                                       data:data
                                        key:key
                                         iv:keyIv];
    NSData *base64Data = [AESData base64EncodedDataWithOptions:0];
    NSString *plaintext = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return plaintext;
}
- (NSString *)decryptWithAES128_Key:(NSString *)key keyIv:(NSString *)keyIv
{
    NSData *baseData = [[NSData alloc]initWithBase64EncodedString:self options:0];
    NSData *AESData = [self AES128operation:kCCDecrypt
                                       data:baseData
                                        key:key
                                         iv:keyIv];
    NSString *decStr = [[NSString alloc] initWithData:AESData encoding:NSUTF8StringEncoding];
    return decStr;
}

- (NSData *)AES128operation:(CCOperation)operation data:(NSData *)data key:(NSString *)key iv:(NSString *)iv {
    
    char keyPtr[kCCKeySizeAES128 + 1];  //kCCKeySizeAES128是加密位数 可以替换成256位的
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // IV
    char ivPtr[kCCBlockSizeAES128 + 1];
    bzero(ivPtr, sizeof(ivPtr));
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    // 设置加密参数
    /**
     这里设置的参数ios默认为CBC加密方式，如果需要其他加密方式如ECB，在kCCOptionPKCS7Padding这个参数后边加上kCCOptionECBMode，即kCCOptionPKCS7Padding | kCCOptionECBMode，但是记得修改上边的偏移量，因为只有CBC模式有偏移量之说
     
     */
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                            keyPtr, kCCKeySizeAES128,
                                            ivPtr,
                                            [data bytes], [data length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess) {
        NSLog(@"Success");
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
    } else {
        NSLog(@"Error");
    }
    
    free(buffer);
    return nil;
}
@end
