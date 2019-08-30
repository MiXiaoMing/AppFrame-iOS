//
//  UIButton+QMGenerate.m
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIButton+QMGenerate.h"
#import "UIImage+QMGenerate.h"

@implementation UIButton (QMGenerate)

+ (instancetype)creatCornerSquareButtonWith:(NSString *)title color:(UIColor *)color
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage squareImageWithColor:color targetSize:CGSizeMake(500, 50)] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}

@end
