//
//  ThirdVC.m
//  AppFrame
//
//  Created by edz on 2019/10/25.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "ThirdVC.h"
#import "AppFrame.h"
#import "UIColor+QM.h"
@interface ThirdVC ()

@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIImage *image = [NSBundle getPodImageWith:nil fileName:@"NavigationBack" type:@"png"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickLeftBarButtonItem) image:image itemSpaces:QMBarItemSpaceMake(0, 0)];
}
- (void)clickLeftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:true];
}


@end
