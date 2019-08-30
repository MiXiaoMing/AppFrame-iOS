//
//  UIButton+QMImgTextPosition.h
//  AFNetworking
//
//  Created by edz on 2019/8/21.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, QMImagePosition) {
    QMImagePositionLeft = 0,              //图片在左，文字在右，默认
    QMImagePositionRight = 1,             //图片在右，文字在左
    QMImagePositionTop = 2,               //图片在上，文字在下
    QMImagePositionBottom = 3,            //图片在下，文字在上
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (QMImgTextPosition)

/**
 设置自定义图片文字位置按钮
 
 @param postion 位置
 @param spacing 图片和文字间隙
 */
- (void)setImagePosition:(QMImagePosition)postion spacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
