//
//  QMAdjustableLabel.h
//  AppFrame
//
//  Created by edz on 2019/9/11.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "QMBaseLabel.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    QMTextAlignNomal,
    QMTextAlignTop,
    QMTextAlignBottom
} QMTextAlign;
@interface QMAdjustableLabel : QMBaseLabel

@property (nonatomic, assign) UIEdgeInsets customEdge;
@property (nonatomic, assign) QMTextAlign textAlign;

@end

NS_ASSUME_NONNULL_END
