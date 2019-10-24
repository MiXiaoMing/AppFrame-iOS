//
//  SecondVC.m
//  AppFrame
//
//  Created by edz on 2019/10/9.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "SecondVC.h"

#import "AppFrame.h"

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
    
    self.plainTableView.frame = self.view.bounds;
    [self.view addSubview:self.plainTableView];
    
    self.showEmptyPlaceView = true;
    [self.plainTableView reloadData];
}

- (void)clickLeftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
