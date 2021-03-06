//
//  SecondVC.m
//  AppFrame
//
//  Created by edz on 2019/10/9.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "SecondVC.h"

#import "AppFrame.h"
#import "ThirdVC.h"
@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.QM_disableInteractivePop = true;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.QM_disableInteractivePop = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [NSBundle getPodImageWith:nil fileName:@"NavigationBack" type:@"png"];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickLeftBarButtonItem) image:image itemSpaces:QMBarItemSpaceMake(15, 15)];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)clickLeftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ThirdVC *vc = [[ThirdVC alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

@end
