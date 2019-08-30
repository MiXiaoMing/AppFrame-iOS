//
//  UIView+QMFrame.h
//  AppFrame
//
//  Created by edz on 2019/7/31.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QMFrame)

@property (nonatomic, assign) CGFloat qm_x;
@property (nonatomic, assign) CGFloat qm_y;

@property (nonatomic, assign) CGFloat qm_width;
@property (nonatomic, assign) CGFloat qm_height;

@property (nonatomic, assign) CGFloat qm_centerX;
@property (nonatomic, assign) CGFloat qm_centerY;

@property (nonatomic, assign) CGSize qm_size;
@property (nonatomic, assign) CGPoint qm_origin;

@property (nonatomic, assign, readonly) CGFloat qm_maxX;
@property (nonatomic, assign, readonly) CGFloat qm_maxY;

@end
