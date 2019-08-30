//
//  NSDictionaryTests.m
//  AppFrameTests
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+QM.h"

@interface NSDictionaryTests : XCTestCase

@end

@implementation NSDictionaryTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


- (void)testNSDictionary_QM {
    NSDictionary *dic1 = @{@"1":[NSNull null],
                           @"2":@"2",
                           @"3":@"31111"
                           };
    NSDictionary *dic2 = @{@"1":@"1",
                           @"2":[NSNull null],
                           @"3":@"3222222"
                           };
    NSDictionary *dic3 = @{};
    
    XCTAssertTrue([[[dic2 dictionaryByReplacingNullsWithBlanks] objectForKey:@"2"] isEqualToString:@""],@"替换成功");
    XCTAssertFalse([[[dic2 dictionaryByReplacingNullsWithBlanks] objectForKey:@"2"] isKindOfClass:[NSNull class]],@"替换失败");
    
    XCTAssertTrue([dic3 isBlankDictionary],@"空字典");
    XCTAssertFalse([dic2 isBlankDictionary],@"非空字典");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
