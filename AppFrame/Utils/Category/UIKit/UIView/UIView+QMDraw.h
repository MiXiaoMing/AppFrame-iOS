//
//  UIView+QMDraw.h
//  AppFrame
//

#import <UIKit/UIKit.h>

@interface UIView (QMDraw)

/**
 给控件本身添加圆角，不是通过图片实现的。要求控件本身的frame是确定的，非自动布局才行。
 
 @param corner 多个圆角可通过UIRectCornerTopLeft | UIRectCornerTopRight这样来使用
 @param cornerRadius 圆角大小
 */
- (void)addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius;

/**
 corner为UIRectCornerAllCorners，bounds大小已经有才能使用
 
 @param cornerRadius 圆角大小
 */
- (void)addCornerRadius:(CGFloat)cornerRadius;

/**
 corner为UIRectCornerAllCorners，bounds要外部指定
 
 @param cornerRadius 圆角大小
 @param targetSize 指frame.size
 */
- (void)addCornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize;

/**
 给控件本身添加圆角，不是通过图片实现的。
 
 @param corner 圆角
 @param cornerRadius 圆角大小
 @param targetSize 目标大小，即控件的frame.size
 */
- (void)addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize;
/**
 绘制虚线
 
 @param pointArr 通过NSStringFromCGPoint传入坐标数组
 @param lineWidth 虚线的宽度
 @param lineLength 虚线的长度
 @param lineSpacing 虚线的间距
 @param lineColor 虚线的颜色
 */
- (void)drawDashLineWithpointArray:(NSArray *)pointArr lineWidth:(float)lineWidth lineLength:(float)lineLength lineSpacing:(float)lineSpacing lineColor:(UIColor *)lineColor;
@end
