//
//  QMBaseTableViewController.h
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "QMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QMBaseTableViewController : QMBaseViewController

/** plain样式
 */
@property (nonatomic,strong) UITableView *plainTableView;
/** group样式
 */
@property (nonatomic,strong) UITableView *groupTableview;
/** 是否显示分割线 */
@property (nonatomic,assign) BOOL isShowSeparator;
/**
 显示空白页
 */
@property (nonatomic, assign) BOOL showEmptyPlaceView;

@end

NS_ASSUME_NONNULL_END
