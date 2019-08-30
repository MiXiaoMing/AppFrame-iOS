//
//  NSObjectTests.m
//  AppFrameTests
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+QM.h"
@interface NSObjectTests : XCTestCase

@end

@implementation NSObjectTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testNSObject_QM {
    UIView *view = [[UIView alloc] init];
    NSDictionary *dic = [view properties_aps];
    
    XCTAssertNotNil(dic);
    
    NSString *string = @"sadfasfasfasf";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = @{@"1":@"1",@"2":@"2",@"3":@"3"};
    NSArray *arr = @[@"1",@"1",@"1",@"1",@"1"];
    NSString *nullStr = @"";
    NSData *nullData = [nullStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *nullDic = @{};
    NSArray *nullArr = @[];
    
    XCTAssertTrue([string isNotEmpty],@"非空");
    XCTAssertFalse([nullStr isNotEmpty],@"空");
    XCTAssertTrue([data isNotEmpty],@"非空");
    XCTAssertFalse([nullData isNotEmpty],@"空");
    XCTAssertTrue([dictionary isNotEmpty],@"非空");
    XCTAssertFalse([nullDic isNotEmpty],@"空");
    XCTAssertTrue([arr isNotEmpty],@"非空");
    XCTAssertFalse([nullArr isNotEmpty],@"空");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
