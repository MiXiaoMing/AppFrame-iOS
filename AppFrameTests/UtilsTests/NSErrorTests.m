//
//  NSErrorTests.m
//  AppFrameTests
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSError+QM.h"

@interface NSErrorTests : XCTestCase

@end

@implementation NSErrorTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testNSError_QM
{
    NSError *error = [NSError errorWithCode:-9999 errorMessage:@"错误信息"];
    XCTAssertNotNil(error);
    XCTAssertEqual([error errorCode], -9999,@"错误码");
    XCTAssertEqual([error errorMsg], @"错误信息");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
