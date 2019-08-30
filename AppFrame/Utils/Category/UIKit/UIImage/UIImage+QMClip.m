//
//  UIImage+QMClip.m
//  AppFrame
//
//  Created by edz on 2019/8/1.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "UIImage+QMClip.h"

@implementation UIImage (QMClip)
- (UIImage *)clipImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    CGFloat imageWH = self.size.width;
    CGFloat border = borderWidth;
    CGFloat ovalWH = imageWH + 2 * border;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    [borderColor set];
    [path fill];
    
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    [clipPath addClip];
    
    [self drawAtPoint:CGPointMake(border, border)];
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return clipImage;
}

- (UIImage *)imageClipRect:(CGRect)cropRect
{
    CGSize imageSize = self.size;
    if (cropRect.origin.x > imageSize.width || cropRect.origin.y > imageSize.height) {
        return nil;
    }
    if (cropRect.origin.x + cropRect.size.width > imageSize.width) {
        cropRect.size.width = imageSize.width - cropRect.origin.x;
    }
    if (cropRect.origin.y + cropRect.size.height > imageSize.height) {
        cropRect.size.height = imageSize.height - cropRect.origin.y;
    }
    UIImage *newImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([self CGImage], cropRect)];
    return newImage;
}

- (UIImage *)stretchableWithedgeInsets:(UIEdgeInsets)edgeInsets
{
    UIImage *image = [self resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeTile];
    
    return image;
}

- (UIImage *)imageChangeSize:(CGSize)newSize isScale:(BOOL)isScale
{
    UIImage *newImage;
    if (isScale) {
        CGFloat width = CGImageGetWidth(self.CGImage);
        CGFloat height = CGImageGetHeight(self.CGImage);
        
        float verticalRadio = newSize.height*1.0/height;
        float horizontalRadio = newSize.width*1.0/width;
        
        float radio = 1;
        if(verticalRadio>1 && horizontalRadio>1)
        {
            radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
        }
        else
        {
            radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
        }
        
        width = width*radio;
        height = height*radio;
        
        int xPos = (newSize.width - width)/2;
        int yPos = (newSize.height-height)/2;
        
        UIGraphicsBeginImageContext(newSize);
        
        [self drawInRect:CGRectMake(xPos, yPos, width, height)];
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }else
    {
        UIGraphicsBeginImageContext(newSize);
        [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newImage;
}

- (UIImage *)clipToSize:(CGSize)targetSize
           cornerRadius:(CGFloat)cornerRadius
                corners:(UIRectCorner)corners
        backgroundColor:(UIColor *)backgroundColor
           isEqualScale:(BOOL)isEqualScale
{
    if (targetSize.width <= 0 || targetSize.height <= 0) {
        return self;
    }
    UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);
    
    CGSize imgSize = self.size;
    
    CGSize resultSize = targetSize;
    if (isEqualScale) {
        CGFloat x = MAX(targetSize.width / imgSize.width, targetSize.height / imgSize.height);
        resultSize = CGSizeMake(x * imgSize.width, x * imgSize.height);
    }
    
    CGRect targetRect = (CGRect){0, 0, resultSize.width, resultSize.height};
    
    
    if (backgroundColor) {
        [backgroundColor setFill];
        CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
    }
    
    if (cornerRadius > 0) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
        CGContextClip(UIGraphicsGetCurrentContext());
    }
    
    [self drawInRect:targetRect];
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}

/**
 裁剪为全圆角图片
 */
- (UIImage *)clipToCornerImageWithCornerRadius:(CGFloat)cornerRadius
{
    return [self clipToSize:self.size cornerRadius:cornerRadius corners:UIRectCornerAllCorners backgroundColor:[UIColor whiteColor] isEqualScale:true];
}

- (UIImage *)clipToCornerImageWithCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners
{
    return [self clipToSize:self.size cornerRadius:cornerRadius corners:corners backgroundColor:[UIColor whiteColor] isEqualScale:true];
}
@end
