//
//  UIViewController+QM.h
//  AppFrame
//
//  Created by edz on 2019/8/30.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (QM)

@property (nonatomic, strong, readonly) UIViewController *currentViewController;

@end

NS_ASSUME_NONNULL_END
