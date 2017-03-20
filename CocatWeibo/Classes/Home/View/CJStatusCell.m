//
//  CJStatusCell.m
//  CocatWeibo
//
//  Created by chenjie on 12/31/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJStatusCell.h"
#import "CJStatusFrame.h"
#import "CJStatus.h"
#import "CJUser.h"
#import "UIImageView+WebCache.h"
#import "CJStatusToolbar.h"
#import "CJStatusTopView.h"
#import "CJReweetStatusView.h"

@interface CJStatusCell()

/** 微博TopView*/
@property (nonatomic, weak) CJStatusTopView *topStatusView;  

/** 微博的工具条 */
@property (nonatomic, weak) CJStatusToolbar *statusToolbar;

@end

@implementation CJStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    CJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[CJStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // 1.添加顶部微博内部的子控件
        [self setupStatusTopView];

        // 2.添加微博的工具条
        [self setupStatusToolBar];
    }
    
    return self;
}


/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += CJStatusTableBorder;
    frame.origin.x = CJStatusTableBorder;
    frame.size.width -= 2 * CJStatusTableBorder;
    frame.size.height -= CJStatusTableBorder;
    [super setFrame:frame];
}

/**
 *  添加顶部微博内部的子控件
 */
- (void)setupStatusTopView
{
    /** 设置cell选中的背景*/
    self.selectedBackgroundView = [[UIView alloc] init];
    self.backgroundColor = [UIColor clearColor];
    
    /** 顶部的view */
    CJStatusTopView *topView = [[CJStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topStatusView = topView;
}

/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar
{
    CJStatusToolbar *statusToolbar = [[CJStatusToolbar alloc] init];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

/**
 *  传递模型数据
 */
- (void)setStatusFrame:(CJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.顶部视图数据
    [self setupStatusTopViewData];
    
    // 2.微博工具条数据
    [self setupStatusToolbarData];
}

/**
 *  顶部视图数据
 */
- (void)setupStatusTopViewData
{
    self.topStatusView.frame = self.statusFrame.topViewF;
    self.topStatusView.statusFrame = self.statusFrame;
}

/**
 *  微博工具条数据
 */
- (void)setupStatusToolbarData
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
    self.statusToolbar.status = self.statusFrame.status;
}


@end
