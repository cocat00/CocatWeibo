//
//  CJSettingCell.m
//  CocatWeibo
//
//  Created by chenjie on 4/27/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJSettingCell.h"
#import "CJSettingItem.h"
#import "CJSettingArrowItem.h"
#import "CJSettingLabelItem.h"
#import "CJSettingSwitchItem.h"
#import "CJBadgeButton.h"


@interface CJSettingCell()

/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *arrowView;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *switchView;
/**
 *  提醒数字
 */
@property (strong, nonatomic) CJBadgeButton *badgeButton;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIImageView *bgView;

@property (nonatomic, weak) UIImageView *selectedBgView;

@end

@implementation CJSettingCell

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (UIImageView *)arrowView
{
    if (_arrowView == nil)
    {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"common_icon_arrow"]];
    }
    
    return _arrowView;
}

- (CJBadgeButton *)badgeButton
{
    if (_badgeButton == nil)
    {
        _badgeButton = [[CJBadgeButton alloc] init];
    }
    
    return _badgeButton;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"setting";
    CJSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[CJSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.tableView = tableView;
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        // 标题
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        // 创建背景
        UIImageView *bgView = [[UIImageView alloc] init];
        self.backgroundView = bgView;
        self.bgView = bgView;
        
        UIImageView *selectedBgView = [[UIImageView alloc] init];
        self.selectedBackgroundView = selectedBgView;
        self.selectedBgView = selectedBgView;
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    if (iOS7)
    {
        frame.origin.x = 5;
        frame.size.width -= 10;
    }
    
    [super setFrame:frame];
}

- (void)setItem:(CJSettingItem *)item
{
    _item = item;
    
    // 1.设置数据
    [self setupData];
    
    // 2.设置右边的控件
    [self setupRightView];
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    // 设置背景的图片
    NSInteger totalRows = [self.tableView numberOfRowsInSection:indexPath.section];
    NSString *bgName = nil;
    NSString *selectedBgName = nil;
    
    if (totalRows == 1)
    {
        // 这组就1行
        bgName = @"common_card_background";
        selectedBgName = @"common_card_background_highlighted";
    }
    else if (indexPath.row == 0)
    {
        // 首行
        bgName = @"common_card_top_background";
        selectedBgName = @"common_card_top_background_highlighted";
    }
    else if (indexPath.row == totalRows - 1)
    {
        // 尾行
        bgName = @"common_card_bottom_background";
        selectedBgName = @"common_card_bottom_background_highlighted";
    }
    else
    {
        // 中行
        bgName = @"common_card_middle_background";
        selectedBgName = @"common_card_middle_background_highlighted";
    }
    self.bgView.image = [UIImage resizedImageWithName:bgName];
    self.selectedBgView.image = [UIImage resizedImageWithName:selectedBgName];
}

/**
 *  设置数据
 */
- (void)setupData
{
    // 1.图标
    if (self.item.icon)
    {
        self.imageView.image = [UIImage imageWithName:self.item.icon];
    }
    
    // 2.标题
    self.textLabel.text = self.item.title;
}

/**
 *  设置右边的控件
 */
- (void)setupRightView
{
    if (self.item.badgeValue)
    {
        self.badgeButton.badgeValue = self.item.badgeValue;
        self.accessoryView = self.badgeButton;
    }
    else if ([self.item isKindOfClass:[CJSettingSwitchItem class]])
    {
        // 右边是开关
        self.accessoryView = self.switchView;
        [self.switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    else if ([self.item isKindOfClass:[CJSettingArrowItem class]])
    {
        // 右边是箭头
        self.accessoryView = self.arrowView;
    }
    else
    {
        // 右边没有东西
        self.accessoryView = nil;
    }
}

- (void)switchAction:(id)sender
{
   if ([self.item isKindOfClass:[CJSettingSwitchItem class]])
   {
       CJSettingSwitchItem *settingSwitchItem = (CJSettingSwitchItem *)self.item;
       if (settingSwitchItem.settingSwitchOperation)
       {
           settingSwitchItem.settingSwitchOperation(_switchView.on);
       }
   }
}

@end
