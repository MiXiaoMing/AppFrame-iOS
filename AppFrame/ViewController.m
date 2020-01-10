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
#import "UIColor+QM.h"
#import "SecondVC.h"
#import "FoundationGlobalHeader.h"
#import "QMNetworkManagerSingle.h"
#import "UIImage+QMGenerate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIImage *image = [NSBundle getPodImageWith:nil fileName:@"NavigationBack" type:@"png"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(clickLeftBarButtonItem) image:image itemSpaces:QMBarItemSpaceMake(0, 0)];
    @weakify(self);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    SecondVC *vc = [[SecondVC alloc] init];
//    [self.navigationController pushViewController:vc animated:true];
    UIImage *uploadImage = [UIImage squareImageWithColor:[UIColor redColor] targetSize:CGSizeMake(50, 50)];

    [[QMNetworkManagerSingle shareInstance] uploadImagesWithURL:@"www.baidu.com" parameters:nil name:@"20191102.jpg" images:@[uploadImage] fileNames:@[@"20191102.jpg"] imageScale:1.0 imageType:@"png" progress:nil success:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
}



@end
