//
//  QMBaseTableViewCell.h
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QMBaseTableViewCell : UITableViewCell

+ (instancetype)tableviewCell:(UITableView *)tableView;

/**
 分割线左边距
 */
- (void)setCellBottomLineLeftSpace:(CGFloat)leftSpace;

/**
 分割线左边距,右边距
 */
- (void)setCellBottomLineLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace;

@end

NS_ASSUME_NONNULL_END
