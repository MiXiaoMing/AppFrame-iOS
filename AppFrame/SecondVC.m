//
//  SecondVC.m
//  AppFrame
//
//  Created by edz on 2019/10/9.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatLeftReturnBarButtonItem];
    self.view.backgroundColor = [UIColor redColor];
    
    self.plainTableView.frame = self.view.bounds;
    [self.view addSubview:self.plainTableView];
    
    self.showEmptyPlaceView = true;
    [self.plainTableView reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
