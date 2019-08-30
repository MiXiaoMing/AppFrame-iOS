//
//  UIView+QMDraw.m
//  AppFrame
//
//  Created by edz on 2019/7/31.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "UIView+QMDraw.h"

@implementation UIView (QMDraw)

- (void)addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize {
    CGRect frame = CGRectMake(0, 0, targetSize.width, targetSize.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame
                                               byRoundingCorners:corner
                                                     cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = frame;
    layer.path = path.CGPath;
    
    self.layer.mask = layer;
}

- (void)addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius {
    [self addCorner:corner cornerRadius:cornerRadius size:self.bounds.size];
}

- (void)addCornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize {
    [self addCorner:UIRectCornerAllCorners cornerRadius:cornerRadius size:targetSize];
}

- (void)addCornerRadius:(CGFloat)cornerRadius {
    [self addCorner:UIRectCornerAllCorners cornerRadius:cornerRadius];
}
- (void)drawDashLineWithpointArray:(NSArray *)pointArr lineWidth:(float)lineWidth lineLength:(float)lineLength lineSpacing:(float)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:lineColor.CGColor];
    [shapeLayer setLineWidth:lineWidth];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint point = CGPointFromString(pointArr[0]);
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    
    for (NSInteger i=1; i<pointArr.count; i++) {
        CGPoint point = CGPointFromString(pointArr[i]);
        CGPathAddLineToPoint(path, NULL, point.x, point.y);
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [self.layer addSublayer:shapeLayer];
}
@end
