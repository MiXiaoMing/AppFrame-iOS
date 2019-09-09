//
//  ViewController.m
//  AppFrame
//
//  Created by 米晓明 on 2019/7/31.
//  Copyright © 2019年 米晓明. All rights reserved.
//

#import "ViewController.h"
#import "AppFrame.h"
#import "QMProgressHUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
//    NSLog(@"1 - %@",[QMAppGlobalConfig sharedInstance].appLanguage);
//    [[QMAppGlobalConfig sharedInstance] setAppCurrentLanguage:@"zh-Hans"];
//    NSLog(@"2 - %@",[QMAppGlobalConfig sharedInstance].appLanguage);
    
    
    
//    UIImage *image = [NSBundle getPodImageWith:nil fileName:@"NavigationBack" type:@"png"];
//
//    NSLog(@"%@",image);
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [QMProgressHUD showTextViewTo:nil bezelViewColor:nil offset:CGPointZero minSize:CGSizeZero backgroundViewColor:nil textColor:[UIColor whiteColor] text:@"asfasfasdfasfasfsafsafsdfasfasfsafsfsafsaffsf" duration:30 complete:^{
//
//        }];
//    });
    
    NSLog(@"--------%ld",IsPhoneX);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
