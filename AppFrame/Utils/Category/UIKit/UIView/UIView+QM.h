//
//  UIView+QM.h
//  AppFrame
//

#import <UIKit/UIKit.h>

@interface UIView (QM)

/**
 返回根视图
 */
- (UIViewController *)rootViewcontroller;

/**
 *    给控件本身添加圆角，不是通过图片实现的。要求控件本身的frame是确定的，非自动布局才行。
 *
 *    @param corner              多个圆角可通过UIRectCornerTopLeft | UIRectCornerTopRight这样来使用
 *    @param cornerRadius    圆角大小
 *
 *  @Example
 *  [cornerView3 hyb_setImage:@"bimg8.jpg" cornerRadius:10 rectCorner:UIRectCornerTopLeft |UIRectCornerBottomRight isEqualScale:NO onCliped:^(UIImage *clipedImage) {
 // 如果需要复用，可在异步剪裁后，得到已剪裁后的图片，可另行他用
 }];
 */
- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius;

/**
 * corner为UIRectCornerAllCorners，bounds大小已经有才能使用
 *
 * @Example
 * 添加一个圆角：[view1 hyb_addCorner:UIRectCornerTopLeft cornerRadius:10];
 */
- (void)hyb_addCornerRadius:(CGFloat)cornerRadius;

/**
 *  corner为UIRectCornerAllCorners，bounds要外部指定
 *
 *    @param cornerRadius    加钱大小
 *    @param targetSize        指frame.size
 */
- (void)hyb_addCornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize;

/**
 *  给控件本身添加圆角，不是通过图片实现的。
 *
 *    @param corner       添加哪些圆角
 *    @param cornerRadius    圆角大小
 *    @param targetSize        目标大小，即控件的frame.size
 */
- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize;


+ (UIView *)configFinishTableFooterVieWithTableView:(UITableView *)tableView;
+ (UIView *)configLineViewWithFrame:(CGRect)frame;
+ (UIView *)configSpaceViewWithFrame:(CGRect)frame;
+ (UIView *)configSpaceViewWithLineFrame:(CGRect)frame;


//画虚线
+ (void)drawDashLine:(UIView *)lineView pointArray:(NSArray *)pointArr lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

// view分类方法 获取view所在控制器
- (UIViewController *)belongViewController;


@end
