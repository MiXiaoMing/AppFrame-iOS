//
//  UINavigationController+QMFullScreen.h
//  CustomNavigationBar
//
//  Created by Barnett on 2017/12/30.
//  Copyright © 2017年 ZQM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (QMFullScreen)
/**
 禁止右滑返回属性
 */
@property (nonatomic, assign) BOOL QM_disableInteractivePop;

@end

@interface UINavigationController (QMFullScreen)
<UIGestureRecognizerDelegate>

@end
