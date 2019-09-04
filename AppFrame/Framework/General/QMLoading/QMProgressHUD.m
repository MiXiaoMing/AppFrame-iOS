//
//  QMProgressHUD.m
//  AppFrame
//
//  Created by edz on 2019/8/27.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "QMProgressHUD.h"
#import "MBProgressHUD.h"
@implementation QMProgressHUD

+ (void)showIndeterminateLoadingViewTo:(nullable UIView *)superView
                        bezelViewColor:(nullable UIColor *)bezelViewColor
                         conctentColor:(nullable UIColor *)contentColor
                                offset:(CGPoint)offset
                   backgroundViewColor:(nullable UIColor *)backgroundViewColor
                             textColor:(nullable UIColor *)textColor
                                  text:(nullable NSString *)contentText
                              duration:(float)duration
                              complete:(void(^_Nullable)(void))complete
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [QMProgressHUD creatNew:superView];
        hud.removeFromSuperViewOnHide = true;
        hud.minShowTime = 1.;
        if (bezelViewColor) {
            hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
            hud.bezelView.backgroundColor = bezelViewColor;
        }
        if (contentColor) {
            hud.contentColor = contentColor;
        }
        if (!CGPointEqualToPoint(offset, CGPointZero)) {
            hud.offset = offset;
        }
        if (backgroundViewColor) {
            hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
            hud.backgroundView.color = backgroundViewColor;
        }
        if (contentText) {
            hud.detailsLabel.text = contentText;
            if (textColor) {
                hud.detailsLabel.textColor = textColor;
            }
        }
        if (duration > CGFLOAT_MAX || duration > NSUIntegerMax || duration > NSIntegerMax) {
            if (complete) {
                complete();
            }
            return;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:true];
            if (complete) {
                complete();
            }
        });
    });
}

/**
 加载菊花
 */
+ (void)showLoadingViewTo:(nullable UIView *)superView
{
    MBProgressHUD *hud = [QMProgressHUD creatNew:superView];
    hud.removeFromSuperViewOnHide = true;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.54];
    hud.contentColor = [UIColor whiteColor];
}
+ (void)showTextViewTo:(nullable UIView *)superView
        bezelViewColor:(nullable UIColor *)bezelViewColor
                offset:(CGPoint)offset
               minSize:(CGSize)minSize
   backgroundViewColor:(nullable UIColor *)backgroundViewColor
             textColor:(nullable UIColor *)textColor
                  text:(nullable NSString *)contentText
              duration:(float)duration
              complete:(void(^_Nullable)(void))complete
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [QMProgressHUD creatNew:superView];
        hud.removeFromSuperViewOnHide = true;
        hud.minShowTime = 1.;
        hud.mode = MBProgressHUDModeText;
        if (bezelViewColor) {
            hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
            hud.bezelView.backgroundColor = bezelViewColor;
        }
        if (!CGPointEqualToPoint(offset, CGPointZero)) {
            hud.offset = offset;
        }
        if (!CGSizeEqualToSize(minSize, CGSizeZero)) {
            hud.minSize = minSize;
        }
        if (backgroundViewColor) {
            hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
            hud.backgroundView.color = backgroundViewColor;
        }
        if (contentText) {
            hud.detailsLabel.text = contentText;
            if (textColor) {
                hud.detailsLabel.textColor = textColor;
                hud.detailsLabel.font = [UIFont systemFontOfSize:16];
            }
        }
        if (duration > CGFLOAT_MAX || duration > NSUIntegerMax || duration > NSIntegerMax) {
            if (complete) {
                complete();
            }
            return;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:true];
            if (complete) {
                complete();
            }
        });
    });
}
+ (void)showCustomViewTo:(nullable UIView *)superView
              customView:(nullable UIView *)customView
          bezelViewColor:(nullable UIColor *)bezelViewColor
           conctentColor:(nullable UIColor *)contentColor
                  offset:(CGPoint)offset
                 minSize:(CGSize)minSize
     backgroundViewColor:(nullable UIColor *)backgroundViewColor
                    text:(nullable NSString *)contentText
                duration:(float)duration
                complete:(void(^_Nullable)(void))complete;
{
    NSAssert(customView == nil, @"自定义视图不能为nil");
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [QMProgressHUD creatNew:superView];
        hud.removeFromSuperViewOnHide = true;
        hud.minShowTime = 1.;
        hud.mode = MBProgressHUDModeCustomView;
        if (bezelViewColor) {
            hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
            hud.bezelView.backgroundColor = bezelViewColor;
        }
        if (contentColor) {
            hud.contentColor = contentColor;
        }
        if (!CGPointEqualToPoint(offset, CGPointZero)) {
            hud.offset = offset;
        }
        if (!CGSizeEqualToSize(minSize, CGSizeZero)) {
            hud.minSize = minSize;
        }
        if (backgroundViewColor) {
            hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
            hud.backgroundView.color = backgroundViewColor;
        }
        if (contentText) {
            hud.detailsLabel.text = contentText;
        }
        if (customView) {
            hud.customView = customView;
        }
        if (duration > CGFLOAT_MAX || duration > NSUIntegerMax || duration > NSIntegerMax) {
            if (complete) {
                complete();
            }
            return;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hideAnimated:true];
            if (complete) {
                complete();
            }
        });
    });
}

+ (void)hiddenAllHub
{
    UIView *superView = (UIView *)[[UIApplication sharedApplication] keyWindow];
    for (UIView *view in superView.subviews) {
        if ([view isMemberOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hub = (MBProgressHUD *)view;
            [hub hideAnimated:true];
        }
    }
}
#pragma mark - private method
+ (MBProgressHUD *)creatNew:(nullable UIView *)view
{
    if (view == nil)
    {
        view = (UIView*)[UIApplication sharedApplication].delegate.window;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    return hud;
}
@end
