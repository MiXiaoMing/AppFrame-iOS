//
//  QMToolsManagerTests.m
//  AppFrameTests
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QMToolsManager.h"
@interface QMToolsManagerTests : XCTestCase

@end

@implementation QMToolsManagerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testQMToolsManager {
    XCTAssertTrue([QMToolsManager getRandomNumberFrom:10 to:100] > 10 && [QMToolsManager getRandomNumberFrom:10 to:100] < 100,@"随机数");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
