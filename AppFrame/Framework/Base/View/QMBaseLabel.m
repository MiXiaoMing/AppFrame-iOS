//
//  QMBaseLabel.m
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "QMBaseLabel.h"

@implementation QMBaseLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self superInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self superInit];
    }
    return self;
}

- (void)superInit
{
    self.textAlign = QMTextAlignNomal;
    self.font = [UIFont systemFontOfSize:16];
    self.textColor = [UIColor blackColor];
    [self adjustsFontSizeToFitWidth];
}

- (void)drawRect:(CGRect)rect
{
    if (self.customEdge.left && self.textAlign == QMTextAlignNomal) {
        [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.customEdge)];
    }else
    {
        [super drawRect:rect];
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    if (self.customEdge.left != 0) {
        textRect.origin.x += self.customEdge.left;
    }
    if (self.textAlign == QMTextAlignTop) {
        CGFloat topMargin = self.customEdge.top > 0 ? self.customEdge.top : 0;
        textRect.origin.y = bounds.origin.y + topMargin;
        if (textRect.origin.y > bounds.size.height - textRect.size.height) {
            textRect.origin.y = bounds.size.height - textRect.size.height;
        }
        return textRect;
    }else if(self.textAlign == QMTextAlignBottom)
    {
        CGFloat bottomMargin = self.customEdge.bottom > 0 ? self.customEdge.bottom : 0;
        textRect.origin.y = bounds.size.height - textRect.size.height - bottomMargin;
        if (textRect.origin.y < textRect.size.height) {
            textRect.origin.y = 0;
        }
        return textRect;
    }else
    {
        return textRect;
    }
}
-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}


@end
