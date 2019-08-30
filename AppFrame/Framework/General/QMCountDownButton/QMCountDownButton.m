//
//  QMCountDownButton.m
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "QMCountDownButton.h"

@interface QMCountDownButton ()

@property (nonatomic, assign, readwrite) BOOL isCountDowning;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation QMCountDownButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.finishTitleString = @"重新发送";
        self.isCountDowning = false;
    }
    return self;
}

- (void)startCountDownWith:(int)second
{
    __block int time = second;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){
            
            [self stopCountDown];
            
        }else{
            self.isCountDowning = true;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setTitle:[NSString stringWithFormat:@"%.2dS", time] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)stopCountDown
{
    dispatch_source_cancel(_timer);
    _timer = nil;
    self.isCountDowning = false;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTitle:self.finishTitleString forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
    });
}

@end
