//
//  UIBarButtonItem+QMCreat.h
//  CustomNavigationBar
//

#import <UIKit/UIKit.h>

typedef struct QMBarItemSpace {
    CGFloat leftSpace;
    CGFloat rightSpace;
}QMBarItemSpace;

UIKIT_STATIC_INLINE QMBarItemSpace QMBarItemSpaceMake(CGFloat left,CGFloat right) {
    QMBarItemSpace space = {left,right};
    return space;
}

@interface UIBarButtonItem (QMCreat)

/**
 根据图片生成UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                        nomalImage:(UIImage *)nomalImage
                  higeLightedImage:(UIImage *)higeLightedImage
                        itemSpaces:(QMBarItemSpace)itemSpaces;
/**
 根据图片生成UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                             image:(UIImage *)image
                        itemSpaces:(QMBarItemSpace)itemSpaces;
/**
 根据图片生成UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                             image:(UIImage *)image;

/**
 根据文字生成UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title
                              font:(UIFont *)font
                        titleColor:(UIColor *)titleColor
                  highlightedColor:(UIColor *)highlightedColor
                        itemSpaces:(QMBarItemSpace)itemSpaces;

/**
 根据文字生成UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title
                        itemSpaces:(QMBarItemSpace)itemSpaces;

/**
 根据文字生成UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title;

/**
 用作修正位置的UIBarButtonItem
 */
+(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width;

@end
