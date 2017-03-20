//
//  CJStatusTopView.m
//  CocatWeibo
//
//  Created by chenjie on 1/26/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJStatusTopView.h"
#import "CJStatus.h"
#import "CJStatusFrame.h"
#import "CJUser.h"
#import "CJReweetStatusView.h"
#import "UIImageView+WebCache.h"
#import "CJPhoto.h"
#import "CJPhotosView.h"

@interface CJStatusTopView()

/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) CJPhotosView *photosView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

@property (nonatomic, weak) CJReweetStatusView *reweetStatusView;

@end

@implementation CJStatusTopView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];

        /** 1.头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /** 2.会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /** 3.配图 */
        CJPhotosView *photosView = [[CJPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        /** 4.昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = CJStatusNameFont;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 5.时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = CJStatusTimeFont;
        timeLabel.textColor = CJColor(240, 140, 19);
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 6.来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = CJStatusSourceFont;
        sourceLabel.textColor = CJColor(135, 135, 135);
        sourceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 7.正文\内容 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = CJColor(39, 39, 39);
        contentLabel.font = CJStatusContentFont;
        contentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        /** 8.添加被转发微博内部的子控件*/
        CJReweetStatusView *reweetStatusView = [[CJReweetStatusView alloc] init];
        [self addSubview:reweetStatusView];
        self.reweetStatusView = reweetStatusView;
        
    }
    
    return self;
}

- (void)setStatusFrame:(CJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    CJStatus *status = statusFrame.status;
    CJUser *user = status.user;

    // 1.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    // 2.vip
    if (user.mbtype > 2)
    {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.vipView.frame = self.statusFrame.vipViewF;
        
        self.nameLabel.textColor = [UIColor orangeColor];
    }
    else
    {
        self.nameLabel.textColor = [UIColor blackColor];
        
        self.vipView.hidden = YES;
    }

    // 3.配图
    if (status.pic_urls.count)
    {
        self.photosView.hidden = NO;
        self.photosView.frame = self.statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
    }
    else
    {
        self.photosView.hidden = YES;
    }
    
    // 4.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    // 5.时间
    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + CJStatusCellBorder * 0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:CJStatusTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    self.timeLabel.text = status.created_at;
    
    // 6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + CJStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:CJStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    self.sourceLabel.text = status.source;
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    CJStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    
    // 8.父控件
    if (retweetStatus)
    {
        self.reweetStatusView.hidden = NO;
        self.reweetStatusView.frame = self.statusFrame.retweetViewF;
        
        //设置被转发微博frame
        self.reweetStatusView.statusFrame = self.statusFrame;
    }
    else
    {
        self.reweetStatusView.hidden = YES;
    }
}

@end
