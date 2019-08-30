//
//  NSNumber+QM.h
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (QM)

/**
 获取一个随机整数,范围在[from, to], 包括from, 包括to
 */
+ (int)getRandomNumberFrom:(int)from to:(int)to;

@end

NS_ASSUME_NONNULL_END
