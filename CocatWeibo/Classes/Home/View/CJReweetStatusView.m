//
//  CJReweetStatusView.m
//  CocatWeibo
//
//  Created by chenjie on 1/26/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJReweetStatusView.h"
#import "CJStatusFrame.h"
#import "CJStatus.h"
#import "CJUser.h"
#import "UIImageView+WebCache.h"
#import "CJPhoto.h"
#import "CJPhotosView.h"

@interface CJReweetStatusView()

/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) CJPhotosView *retweetPhotosView;

@end

@implementation CJReweetStatusView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
        
        /** 1.被转发微博作者的昵称 */
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.font = CJRetweetStatusNameFont;
        retweetNameLabel.textColor = CJColor(67, 107, 163);
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        /** 2.被转发微博的正文\内容 */
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.font = CJRetweetStatusContentFont;
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        retweetContentLabel.numberOfLines = 0;
        retweetContentLabel.textColor = CJColor(90, 90, 90);
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        /** 3.被转发微博的配图 */
        CJPhotosView *retweetPhotosView = [[CJPhotosView alloc] init];
        [self addSubview:retweetPhotosView];
        self.retweetPhotosView = retweetPhotosView;
    }
    
    return self;
}

- (void)setStatusFrame:(CJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    CJStatus *retweetStatus = statusFrame.status.retweeted_status;
    CJUser *user = statusFrame.status.retweeted_status.user;
    
    // 1.昵称
    self.retweetNameLabel.text = user.name;
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
    
    // 2.正文
    self.retweetContentLabel.text = retweetStatus.text;
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
    
    // 3.配图
    if (retweetStatus.pic_urls.count)
    {
        self.retweetPhotosView.hidden = NO;
        self.retweetPhotosView.frame = self.statusFrame.retweetPhotosViewF;
        self.retweetPhotosView.photos = retweetStatus.pic_urls;
    }
    else
    {
        self.retweetPhotosView.hidden = YES;
    }
}

@end
