//
//  NSTimer+QMBlocksKit.h
//  AppFrame
//
//  Created by edz on 2019/7/31.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (QMBlocksKit)

/**
 scheduled方法创建timer
 */
+ (NSTimer *)bk_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))inBlock repeats:(BOOL)inRepeats;

/**
 timer方法创建timer
 */
+ (NSTimer *)bk_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))inBlock repeats:(BOOL)inRepeats;

/**
 倒计时(GCD实现)
 
 @param second 总时间
 @param completeBlock 完成回调
 @param progressBlock 过程回调
 */
+ (void)countDown:(NSTimeInterval)second complete:(void(^)(void))completeBlock progress:(void(^)(id time))progressBlock;
@end
