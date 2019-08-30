//
//  UIView+QMFrame.m
//  AppFrame
//
//  Created by edz on 2019/7/31.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "UIView+QMFrame.h"

@implementation UIView (QMFrame)

- (void)setQm_x:(CGFloat)qm_x
{
    CGRect frame = self.frame;
    frame.origin.x = qm_x;
    self.frame = frame;
}

- (void)setQm_y:(CGFloat)qm_y
{
    CGRect frame = self.frame;
    frame.origin.y = qm_y;
    self.frame = frame;
}

- (CGFloat)qm_x
{
    return self.frame.origin.x;
}

- (CGFloat)qm_y
{
    return self.frame.origin.y;
}

- (void)setQm_centerX:(CGFloat)qm_centerX
{
    CGPoint center = self.center;
    center.x = qm_centerX;
    self.center = center;
}

- (void)setQm_centerY:(CGFloat)qm_centerY
{
    CGPoint center = self.center;
    center.y = qm_centerY;
    self.center = center;
}

- (CGFloat)qm_centerX
{
    return self.center.x;
}

- (CGFloat)qm_centerY
{
    return self.center.y;
}

- (void)setQm_width:(CGFloat)qm_width
{
    CGRect frame = self.frame;
    frame.size.width = qm_width;
    self.frame = frame;
}

- (void)setQm_height:(CGFloat)qm_height
{
    CGRect frame = self.frame;
    frame.size.height = qm_height;
    self.frame = frame;
}

- (CGFloat)qm_width
{
    return self.frame.size.width;
}

- (CGFloat)qm_height
{
    return self.frame.size.height;
}

- (void)setQm_size:(CGSize)qm_size
{
    CGRect frame = self.frame;
    frame.size = qm_size;
    self.frame = frame;
}

- (void)setQm_origin:(CGPoint)qm_origin
{
    CGRect frame = self.frame;
    frame.origin = qm_origin;
    self.frame = frame;
}

- (CGSize)qm_size
{
    return self.frame.size;
}

- (CGPoint)qm_origin
{
    return self.frame.origin;
}


- (CGFloat)qm_maxX
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)qm_maxY
{
    return self.frame.origin.y + self.frame.size.height;
}


@end
