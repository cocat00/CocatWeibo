//
//  CJStatusFrame.m
//  CocatWeibo
//
//  Created by chenjie on 12/31/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJStatusFrame.h"
#import "CJStatus.h"
#import "CJUser.h"
#import "CJPhotosView.h"

@implementation CJStatusFrame

/**
 *  获得微博模型数据之后, 根据微博数据计算所有子控件的frame
 */
- (void)setStatus:(CJStatus *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * CJStatusTableBorder;
    
    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    // 2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = CJStatusCellBorder;
    CGFloat iconViewY = CJStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + CJStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithFont:CJStatusNameFont];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 4.会员图标
    if (status.user.mbtype > 2)
    {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + CJStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    // 5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + CJStatusCellBorder * 0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:CJStatusTimeFont];
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + CJStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:CJStatusSourceFont];
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.微博正文内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF)) + CJStatusCellBorder;
    CGFloat contentLabelMaxW = topViewW - 2 * CJStatusCellBorder;
    CGSize contentLabelSize = [status.text sizeWithFont:CJStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 8.配图
    if (status.pic_urls.count)
    {
        //根据图片个数计算整个相册的尺寸
        CGSize photosViewSize = [CJPhotosView photosViewSizeWithPhotosCount:(int)status.pic_urls.count];
        CGFloat photosViewX = contentLabelX;
        CGFloat photosViewY = CGRectGetMaxY(_contentLabelF) + CJStatusCellBorder;
        _photosViewF = CGRectMake(photosViewX, photosViewY, photosViewSize.width, photosViewSize.height);
    }
    
    // 9.被转发微博
    if (status.retweeted_status)
    {
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + CJStatusCellBorder * 0.5;
        CGFloat retweetViewH = 0;
        
        // 10.被转发微博的昵称
        CGFloat retweetNameLabelX = CJStatusCellBorder;
        CGFloat retweetNameLabelY = CJStatusCellBorder;
        CGSize retweetNameLabelSize = [status.retweeted_status.user.name sizeWithFont:CJRetweetStatusNameFont];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        // 11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + CJStatusCellBorder * 0.5;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * CJStatusCellBorder;
        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:CJRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};
        
        // 12.被转发微博的配图
        if(status.retweeted_status.pic_urls.count)
        {
            //根据图片个数计算整个相册的尺寸
            CGSize retweetPhotosViewSize = [CJPhotosView photosViewSizeWithPhotosCount:(int)status.retweeted_status.pic_urls.count];
            CGFloat retweetPhotosViewX = retweetContentLabelX;
            CGFloat retweetPhotosViewY = CGRectGetMaxY(_retweetContentLabelF) + CJStatusCellBorder;
            _retweetPhotosViewF = CGRectMake(retweetPhotosViewX, retweetPhotosViewY, retweetPhotosViewSize.width, retweetPhotosViewSize.height);
            
            retweetViewH = CGRectGetMaxY(_retweetPhotosViewF);
        }
        else
        { // 没有配图
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += CJStatusCellBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        // 有转发微博时topViewH
        topViewH = CGRectGetMaxY(_retweetViewF);
    }
    else   // 没有转发微博
    {
        if (status.pic_urls.count)
        {
            //有图
            topViewH = CGRectGetMaxY(_photosViewF);
        }
        else
        {
            //无图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH += CJStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 13.工具条
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolbarH = 35;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + CJStatusTableBorder;
}

@end