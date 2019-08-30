//
//  NSArrayTests.m
//  AppFrameTests
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+QMSort.h"
#import "NSArray+QM.h"

@interface NSArrayTests : XCTestCase

@end

@implementation NSArrayTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testNSArray_QM {
    NSArray *array = @[@"0",@"1",@"2",[NSNull null],@"4",@"5",@"0",@"1",@"2"];
    id content = [array objectAtIndex:65];
    NSLog(@"%@",content);
    
    NSArray *newArr = [array arrayByReplacingNullsWithBlanks];
    XCTAssertTrue([[newArr objectAtIndex:3] isEqualToString:@""]);
    XCTAssertFalse([[newArr objectAtIndex:3] isKindOfClass:[NSNull class]]);
    
    newArr = [newArr filterTheSameElement];
    XCTAssertTrue(newArr.count == 6);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
