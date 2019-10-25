//
//  QMBaseTableViewCell.m
//  AppFrame
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 米晓明. All rights reserved.
//

#import "QMBaseTableViewCell.h"

@implementation QMBaseTableViewCell

+ (instancetype)tableviewCell:(UITableView *)tableView
{
    Class cls = [self class];
    NSString *identifier = NSStringFromClass(cls);
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return self;
}

- (void)setCellBottomLineLeftSpace:(CGFloat)leftSpace
{
    self.layoutMargins = UIEdgeInsetsMake(0, leftSpace, 0, 0);
    self.separatorInset = UIEdgeInsetsMake(0, leftSpace, 0, 0);
}

/**
 分割线左边距,右边距
 */
- (void)setCellBottomLineLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace
{
    self.layoutMargins = UIEdgeInsetsMake(0, leftSpace, 0, rightSpace);
    self.separatorInset = UIEdgeInsetsMake(0, leftSpace, 0, rightSpace);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
