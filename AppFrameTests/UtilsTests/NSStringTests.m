//
//  NSStringTests.m
//  AppFrameTests
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+QM.h"
#import "NSString+QMEncrypt.h"
#import "NSString+QMVerification.h"
@interface NSStringTests : XCTestCase

@end

@implementation NSStringTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testNSString_QM {
    NSString *testStr = @"1234567890qwertyuiopasdfghjklzxcvbnm";
//    NSString *sub = [testStr substringFromIndex:100];
//    XCTAssertNil(sub);
    
    XCTAssertTrue([testStr getWidthFromfont:16] != 0,@"字符串宽度");
    XCTAssertTrue([testStr getWidthWithSize:CGSizeMake(30, 100) andFont:[UIFont systemFontOfSize:16]] != 0,@"字符串宽度");
    XCTAssertTrue([testStr getHeightWithSize:CGSizeMake(20, 100) andFont:[UIFont systemFontOfSize:16]] != 0,@"字符串高度");
    XCTAssertFalse(CGSizeEqualToSize([testStr getSizeWithSize:CGSizeMake(100, 100) andFont:[UIFont systemFontOfSize:16]], CGSizeZero) ,@"字符串size");
    
    NSString *testStr2 = @"\n\n测试字符串\n";
    XCTAssertEqualObjects(@"测试字符串",[testStr2 removeFirstAndLastLineBreak],@"移除首尾换行符");
    
    XCTAssertEqualObjects(@"77656c636f6d6520746f206265696a696e67",[@"welcome to beijing" hexString],@"银行卡格式");
    
    NSString *testStr3 = @"safsadfsadfsdf \\U6df1\\U5733\\U56fd";
    NSLog(@"----%@",[testStr3 replaceUnicode]);
    
    NSString *idCardStr = @"130209194509290218";
    XCTAssertEqualObjects(@"130209 1945 0929 0218",[idCardStr idCardFormat],@"身份证号码格式");
    
    NSString *bankNumber = @"6217000780021720899";
    XCTAssertEqualObjects(@"6217 0007 8002 1720 899",[bankNumber creditCardFormat],@"银行卡格式");
    
    XCTAssertEqualObjects(testStr,[[testStr encode] decode],@"编码");
    
}
- (void)testNSString_QMEncrypt {
    NSString *str = @"一段需要加密的字符串";
    XCTAssertEqualObjects([str MD5Encrypt], @"9808a09207f1c804278797f9c22a6126",@"MD5加密");
}
- (void)testNSString_QMVerification {
    XCTAssertTrue([@"" isNull],@"空");
    XCTAssertFalse([@"测试" isNull],@"非空");
    
    XCTAssertFalse([@"19188489076" isValidateMobile],@"手机号码");
    
    XCTAssertTrue([@"13020619980978098X" isValidateIdentityCard],@"身份证号码有效");
    XCTAssertFalse([@"130206199809748098X" isValidateIdentityCard],@"身份证号码无效");
    
    XCTAssertTrue([@"zjx123124@163.com" isValidateEmail],@"邮箱有效");
    XCTAssertFalse([@"zjx123124163.com" isValidateEmail],@"邮箱有效");
    
    XCTAssertTrue([@"3445645645645" isValidateQQ],@"有效qq");
    XCTAssertFalse([@"124" isValidateQQ],@"无效qq");
    
    XCTAssertTrue([@"wx_sdfasfsaf_23423" isValidateWechat],@"有效微信号");
    XCTAssertFalse([@"张" isValidateWechat],@"无效微信号");
    
    XCTAssertTrue([@"张safsa13421" isValidateHanNumChar],@"汉字数字字母");
    XCTAssertFalse([@"zhang*&^%$#@" isValidateHanNumChar],@"非汉字数字字母");
    
    XCTAssertTrue([@"safsa13421" isValidateNumChar],@"数字字母");
    XCTAssertFalse([@"张safsa13421" isValidateNumChar],@"非数字字母");
    
    XCTAssertTrue([@"张safsa13421__" isChineseCharacterAndLettersAndNumbersAndUnderScore],@"汉字，字母，数字和下划线组成");
    XCTAssertFalse([@"张zhang*&^%$#@——__" isChineseCharacterAndLettersAndNumbersAndUnderScore],@"非汉字，字母，数字和下划线组成");
    
    XCTAssertTrue([@"zhang*&^%$#@😂" isContainsEmoji],@"有表情");
    XCTAssertFalse([@"zhang*&^%$#@" isContainsEmoji],@"无表情");
}

@end
