//
//  UIButton+QMGenerate.h
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (QMGenerate)

/**
 创建长方形圆角按钮
 */
+ (instancetype)creatCornerSquareButtonWith:(NSString *)title color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
