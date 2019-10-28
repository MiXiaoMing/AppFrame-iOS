//
//  UIKitGlobalHeader.h
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#ifndef UIKitGlobalHeader_h
#define UIKitGlobalHeader_h

// 获取视图尺寸
#define kGetWidth(view) CGRectGetWidth(view.frame)
#define kGetHeight(view) CGRectGetHeight(view.frame)
#define kGetMaxX(view) CGRectGetMaxX(view.frame)
#define kGetMidX(view) CGRectGetMidX(view.frame)
#define kGetMinX(view) CGRectGetMinX(view.frame)
#define kGetMinY(view) CGRectGetMinY(view.frame)
#define kGetMidY(view) CGRectGetMidY(view.frame)
#define kGetMaxY(view) CGRectGetMaxY(view.frame)

#define KSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define KSCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

// 判断设备
#define IsPhoneX ([UIScreen mainScreen].bounds.size.height == 812||[UIScreen mainScreen].bounds.size.height == 896)
#define IsPhone5 ([UIScreen mainScreen].bounds.size.width == 320)

// 颜色转换
#define kColorWith_RGBA(r, g, b, a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]
#define kColorWith_RGB(r,g,b) kColorWith_RGBA(r,g,b,1.0f)
#define kColorWith_RGBA_Hex(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define kColorWith_RGB_Hex(rgbValue) kColorWith_RGBA_Hex(rgbValue, 1.0f)


// 适配比例
#define kWidthScale (KSCREEN_WIDTH/375.0)
#define kHeight(h) (h*(KSCREEN_HEIGHT/667.0))
#define kWidth(w) ceil(w*kWidthScale)
#define kFloorWidth(w) floor(w*kWidthScale)
#define kStatusBarHeight (IsPhoneX?44:20)
#define kBottomSafeAreaInsets (IsPhoneX?34:0)
#define SCREEN_ORIGINY ([[UIApplication sharedApplication] statusBarFrame].size.height + 44.0f)
#define kTabBarHeight (IsPhoneX ? 83:49)

// 文字大小
#define kFont(font) [UIFont systemFontOfSize:font]
#define kBoldFont(font) [UIFont boldSystemFontOfSize:font]
#define QMImage(imageName) [UIImage imageNamed:imageName]

//AppDelegate
#define APP_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define QMApplication [UIApplication sharedApplication]

#define QMAppWindow [UIApplication sharedApplication].delegate.window

#define QMRootViewController [UIApplication sharedApplication].delegate.window.rootViewController

#define QMUserDefaults [NSUserDefaults standardUserDefaults]

#define QMNotificationCenter [NSNotificationCenter defaultCenter]

#endif /* UIKitGlobalHeader_h */
