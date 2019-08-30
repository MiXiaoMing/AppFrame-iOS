//
//  NSNumber+QM.m
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSNumber+QM.h"

@implementation NSNumber (QM)

+ (int)getRandomNumberFrom:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

@end
