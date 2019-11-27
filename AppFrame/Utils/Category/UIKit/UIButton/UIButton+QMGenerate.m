//
//  UIButton+QMGenerate.m
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIButton+QMGenerate.h"
#import "UIImage+QMGenerate.h"
#import <objc/runtime.h>

#import "UIKitGlobalHeader.h"
#import "UIView+QMDraw.h"

@implementation UIButton (QMGenerate)

+ (instancetype)creatCornerSquareButtonWith:(NSString *)title color:(UIColor *)color
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage squareImageWithColor:color targetSize:CGSizeMake(500, 50)] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)createBlueWidthButtonWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)color andTitle:(NSString *)title andTitleFont:(NSInteger)fontSize class:(id)classObject action:(SEL)action {
    UIButton * button = [UIButton createButtonWithFrame:frame andBackgroundColor:color andTitle:title andTitleFont:fontSize class:classObject action:action];
    button.layer.borderColor = kColorWith_RGB_Hex(0x6c9ed6).CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 5;
    return button;
}


+ (UIButton *)createButtonWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)color andTitle:(NSString *)title andTitleFont:(NSInteger)fontSize class:(id)classObject action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = color;

    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:classObject action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame andImage:(NSString *)imageName
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame andSetImage:(NSString *)imageName
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame andSetImage:(NSString *)imageName andTitle:(NSString *)title andTitleFont:(UIFont *)titleFont andTitleColor:(UIColor *)titleColor {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = titleFont;
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame andTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroudColor
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:backgroudColor];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)configReplyButtonWithAlignment:(UIControlContentHorizontalAlignment)aligment {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:kColorWith_RGB_Hex(0xaaaaaa) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    button.bounds = CGRectMake(0, 0, 40*kFontTimes, 12*kFontTimes);
    button.titleEdgeInsets = UIEdgeInsetsMake(0.5*kWidthScale, 1.5*kFontTimes, 0, 0);
    [button setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    if (is_iPhone6) {
        button.imageEdgeInsets = UIEdgeInsetsMake(kWidthScale, 0, 0, 0);
    } else if (is_iPhone6p) {
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 1.5*kFontTimes, 0.5, 0);
    }
    button.contentHorizontalAlignment = aligment;
    [button setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];

    return button;
}

+ (UIButton *)configBUttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundcolor:(UIColor *)backgroundColor titleFont:(UIFont *)titleFont {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    button.titleLabel.font = titleFont;
    return button;
}

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (void)setEnlargeEdge:(CGFloat) size
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}

+ (UIButton *)configBadgeButton {
    UIButton *badgeLabel = [[UIButton alloc]init];
    badgeLabel.titleLabel.font = [UIFont boldSystemFontOfSize:9];
    [badgeLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    badgeLabel.backgroundColor = kColorWith_RGB_Hex(0xf6746a);
    return badgeLabel;
}

- (void)adaptBadgeButton {
    if (self.titleLabel.text.integerValue == 0) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
        [self sizeToFit];
        if (self.titleLabel.text.integerValue<10) {
            self.bounds = CGRectMake(0, 0, MAX(self.frame.size.width, self.frame.size.height), MAX(self.frame.size.width, self.frame.size.height));
        } else {
            self.bounds = CGRectMake(0, 0, self.frame.size.width+5, self.frame.size.height);
        }
        
        [self addCornerRadius:self.frame.size.width/2];
        
        self.clipsToBounds = YES;
        
    }
}
@end
