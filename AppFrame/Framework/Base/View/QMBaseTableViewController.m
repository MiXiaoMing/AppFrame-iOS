//
//  QMBaseTableViewController.m
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "QMBaseTableViewController.h"

@interface QMBaseTableViewController ()
<UITableViewDelegate,UITableViewDataSource>
@end

@implementation QMBaseTableViewController

- (void)setIsShowSeparator:(BOOL)isShowSeparator
{
    _isShowSeparator = isShowSeparator;
    if (_plainTableView) {
        _plainTableView.separatorStyle = isShowSeparator ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
        [_plainTableView reloadData];
    }
    if (_groupTableview) {
        _groupTableview.separatorStyle = isShowSeparator ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
        [_groupTableview reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isShowSeparator = true;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}

#pragma mark - lazy load
- (UITableView *)plainTableView
{
    if (!_plainTableView) {
        _plainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _plainTableView.backgroundColor = [UIColor whiteColor];
        _plainTableView.delegate = self;
        _plainTableView.dataSource = self;
        _plainTableView.showsHorizontalScrollIndicator = false;
        _plainTableView.showsVerticalScrollIndicator = false;
    }
    return _plainTableView;
}

- (UITableView *)groupTableview
{
    if (!_groupTableview) {
        _groupTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _groupTableview.backgroundColor = [UIColor whiteColor];
        _groupTableview.delegate = self;
        _groupTableview.dataSource = self;
        _groupTableview.showsHorizontalScrollIndicator = false;
        _groupTableview.showsVerticalScrollIndicator = false;
    }
    return _groupTableview;
}


@end
