//
//  ViewController.m
//  AppFrame
//
//  Created by 米晓明 on 2019/7/31.
//  Copyright © 2019年 米晓明. All rights reserved.
//

#import "ViewController.h"
#import "AppFrame.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    NSLog(@"1 - %@",[QMAppGlobalConfig sharedInstance].appLanguage);
    [[QMAppGlobalConfig sharedInstance] setAppCurrentLanguage:@"zh-Hans"];
    NSLog(@"2 - %@",[QMAppGlobalConfig sharedInstance].appLanguage);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
