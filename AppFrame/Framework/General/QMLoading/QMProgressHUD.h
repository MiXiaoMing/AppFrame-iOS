//
//  QMProgressHUD.h
//  AppFrame
//
//  Created by edz on 2019/8/27.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MBProgressHUD;
NS_ASSUME_NONNULL_BEGIN

@interface QMProgressHUD : NSObject

/**
 加载菊花带文字
 */
+ (void)showIndeterminateLoadingViewTo:(nullable UIView *)superView
                        bezelViewColor:(nullable UIColor *)bezelViewColor
                         conctentColor:(nullable UIColor *)contentColor
                                offset:(CGPoint)offset
                   backgroundViewColor:(nullable UIColor *)backgroundViewColor
                             textColor:(nullable UIColor *)textColor
                                  text:(nullable NSString *)contentText
                              duration:(float)duration
                              complete:(void(^_Nullable)(void))complete;
/**
 加载菊花
 */
+ (void)showLoadingViewTo:(nullable UIView *)superView;

/**
 显示文本框
 */
+ (void)showTextViewTo:(nullable UIView *)superView
        bezelViewColor:(nullable UIColor *)bezelViewColor
                offset:(CGPoint)offset
               minSize:(CGSize)minSize
   backgroundViewColor:(nullable UIColor *)backgroundViewColor
             textColor:(nullable UIColor *)textColor
                  text:(nullable NSString *)contentText
              duration:(float)duration
              complete:(void(^_Nullable)(void))complete;
/**
 显示自定义视图文本
 */
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

/**
 隐藏所有hud
 */
+ (void)hiddenAllHub;
@end

NS_ASSUME_NONNULL_END
