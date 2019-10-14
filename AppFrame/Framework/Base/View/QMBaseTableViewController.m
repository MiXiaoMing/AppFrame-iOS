//
//  QMBaseTableViewController.m
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "QMBaseTableViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "NSBundle+QMPod.h"
@interface QMBaseTableViewController ()
<UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>
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
#pragma mark - DZNEmptyDataSetSource DZNEmptyDataSetDelegate
//空白页图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    UIImage *image = [NSBundle getPodImageWith:@"AppFrame" fileName:@"NavigationBack" type:@"png"];
//    UIImage *image = [NSBundle getPodImageWith:@"" fileName:@"EmptyPlaceholderView" type:@"png"];
    return image;
}

//详情文字
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂无内容";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//空白页背景色
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    UIColor *color = [UIColor colorWithRed:((float)((0xf4f4f4 & 0xFF0000) >> 16))/255.0 green:((float)((0xf4f4f4 & 0xFF00) >> 8))/255.0 blue:((float)(0xf4f4f4 & 0xFF))/255.0 alpha:1];
    return color;
}

//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.showEmptyPlaceView;
}
//是否允许点击，默认YES
//- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
//    return NO;
//}
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
//{
//    NSLog(@"点击");
//}
//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tmpTableView = (UITableView *)scrollView;
        return tmpTableView.tableHeaderView.frame.size.height/2.0f;
    }else{
        return 0;
    }
}
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    //scrollView.contentOffset = CGPointZero;
    if ([scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tmpTableView = (UITableView *)scrollView;
        if (!tmpTableView.tableHeaderView) {
            [UIView animateWithDuration:0.5 animations:^{
                scrollView.contentOffset = CGPointZero;
            }];
        }
    }
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
        _plainTableView.emptyDataSetDelegate = self;
        _plainTableView.emptyDataSetSource = self;
        _plainTableView.tableFooterView = [[UIView alloc] init];
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
        _groupTableview.emptyDataSetSource = self;
        _groupTableview.emptyDataSetDelegate = self;
        _groupTableview.tableFooterView = [[UIView alloc] init];
    }
    return _groupTableview;
}


@end
