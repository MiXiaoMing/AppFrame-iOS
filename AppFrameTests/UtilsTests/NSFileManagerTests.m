//
//  NSFileManagerTests.m
//  AppFrameTests
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSFileManager+QM.h"

@interface NSFileManagerTests : XCTestCase

@end

@implementation NSFileManagerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"test001"];
    
    XCTAssertTrue([NSFileManager isFileExists:documentsPath],@"文件存在");
    XCTAssertFalse([NSFileManager isFileExists:filePath],@"文件不存在");
//    XCTAssertTrue([NSFileManager isTimeoutWithPath:documentsPath time:24*3600],@"超过设置时间");
        XCTAssertFalse([NSFileManager isTimeoutWithPath:documentsPath time:24*3600],@"未超过设置时间");
    
    NSString *filePath1 = [documentsPath stringByAppendingPathComponent:@"test002"];
    XCTAssertTrue([NSFileManager resetFinderWithPath:filePath1],@"重置文件夹");
    
    NSString *filePath2 = [documentsPath stringByAppendingPathComponent:@"test003"];
    XCTAssertTrue([NSFileManager removeFileWithPath:filePath2],@"删除文件");
    
    NSString *filePath3 = [documentsPath stringByAppendingPathComponent:@"test004"];
    NSLog(@"文件大小：%@",[NSFileManager fileSizeAtPath:filePath3]);
    XCTAssertFalse([NSFileManager isAMR:filePath3]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
