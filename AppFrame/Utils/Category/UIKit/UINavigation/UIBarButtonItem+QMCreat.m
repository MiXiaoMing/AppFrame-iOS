//
//  UIBarButtonItem+QMCreat.m
//  CustomNavigationBar
//

#import "UIBarButtonItem+QMCreat.h"

@implementation UIBarButtonItem (QMCreat)
+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                        nomalImage:(UIImage *)nomalImage
                  higeLightedImage:(UIImage *)higeLightedImage
                        itemSpaces:(QMBarItemSpace)itemSpaces
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:[nomalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    if (higeLightedImage) {
        [button setImage:higeLightedImage forState:UIControlStateHighlighted];
    }
    [button sizeToFit];
    itemSpaces.leftSpace = itemSpaces.leftSpace > 0?itemSpaces.leftSpace:0;
    itemSpaces.rightSpace = itemSpaces.rightSpace > 0?itemSpaces.rightSpace:0;
    CGFloat width = nomalImage.size.width + itemSpaces.leftSpace + itemSpaces.rightSpace;
    
    button.bounds = CGRectMake(0, 0, width, 44);
    
    CGFloat offset = itemSpaces.leftSpace - itemSpaces.rightSpace;
    if (offset != 0) {
        UIEdgeInsets inset = offset > 0 ? UIEdgeInsetsMake(0, offset, 0, 0):UIEdgeInsetsMake(0, 0, 0, -offset);
        button.imageEdgeInsets = inset;
    }
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image itemSpaces:(QMBarItemSpace)itemSpaces
{
    return [self itemWithTarget:target action:action nomalImage:image higeLightedImage:nil itemSpaces:itemSpaces];
}
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image {
    CGFloat width = image.size.width;
    CGFloat space = (44-width)>0 ? (44.0-width)/2:0;
    return [self itemWithTarget:target action:action nomalImage:image higeLightedImage:nil itemSpaces:QMBarItemSpaceMake(space, space)];
}


+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title
                              font:(UIFont *)font
                        titleColor:(UIColor *)titleColor
                  highlightedColor:(UIColor *)highlightedColor
                        itemSpaces:(QMBarItemSpace)itemSpaces {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font?font:nil;
    [button setTitleColor:titleColor?titleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor?highlightedColor:nil forState:UIControlStateHighlighted];
    
    CGSize titleSize = [button sizeThatFits:CGSizeZero];
    titleSize = CGSizeMake(ceil(titleSize.width), ceil(titleSize.height));
    
    itemSpaces.leftSpace = itemSpaces.leftSpace > 0?itemSpaces.leftSpace:0;
    itemSpaces.rightSpace = itemSpaces.rightSpace > 0?itemSpaces.rightSpace:0;
    CGFloat width = titleSize.width + itemSpaces.leftSpace + itemSpaces.rightSpace;
    if (itemSpaces.leftSpace == 0 && itemSpaces.rightSpace == 0) {
        width = width < 44?44:width;
    }
    button.bounds = CGRectMake(0, 0, width, 44);
    
    CGFloat offset = itemSpaces.leftSpace - itemSpaces.rightSpace;
    if (offset != 0) {
        UIEdgeInsets inset = offset > 0 ? UIEdgeInsetsMake(0, offset, 0, 0):UIEdgeInsetsMake(0, 0, 0, -offset);
        button.titleEdgeInsets = inset;
    }
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title {
    
    return [self itemWithTarget:target action:action title:title font:nil titleColor:nil highlightedColor:nil itemSpaces:QMBarItemSpaceMake(0, 0)];
}

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title itemSpaces:(QMBarItemSpace)itemSpaces
{
    return [self itemWithTarget:target action:action title:title font:nil titleColor:nil highlightedColor:nil itemSpaces:itemSpaces];
}



+(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end
