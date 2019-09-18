//
//  QMBaseViewController.m
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "QMBaseViewController.h"
#import "NSBundle+QMPod.h"
#import "UIBarButtonItem+QMCreat.h"

#define AppearBackImage @"AppearBackImage"

@interface QMBaseViewController ()

@end

@implementation QMBaseViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (self.navigationController.viewControllers.count != 1) {
        [self creatLeftReturnBarButtonItem];
    }
}
/**
 返回按钮点击
 */
- (void)clickLeftBarButtonItem {
    if (self.navigationController.viewControllers.count != 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

/**
 返回按钮
 */
- (void)creatLeftReturnBarButtonItem
{
    UIImage *image = [[NSUserDefaults standardUserDefaults] objectForKey:AppearBackImage];
    if (image == nil) {
        image = [NSBundle getPodImageWith:@"AppFrame" fileName:@"NavigationBack" type:@"png"];
    }
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickLeftBarButtonItem) image:image itemSpaces:QMBarItemSpaceMake(17, 17)];
}
+ (void)setAppearBackImage:(UIImage *)image
{
    [[NSUserDefaults standardUserDefaults] setObject:image forKey:AppearBackImage];
}

- (void)setEmptyViewInitialState
{
    
}
@end
