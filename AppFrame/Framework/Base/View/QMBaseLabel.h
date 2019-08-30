//
//  QMBaseLabel.h
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    QMTextAlignNomal,
    QMTextAlignTop,
    QMTextAlignBottom
} QMTextAlign;
NS_ASSUME_NONNULL_BEGIN

@interface QMBaseLabel : UILabel
@property (nonatomic, assign) UIEdgeInsets customEdge;
@property (nonatomic, assign) QMTextAlign textAlign;
@end

NS_ASSUME_NONNULL_END
