//
//  CJSearchBar.m
//  CocatWeibo
//
//  Created by chenjie on 11/24/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJSearchBar.h"

@implementation CJSearchBar


+ (instancetype)searchBar
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 背景
        self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
        
        // 左边的放大镜图标
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 字体
        self.font = [UIFont systemFontOfSize:13];
        
        // 右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 设置提醒文字
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attrs];
        
        // 设置键盘右下角按钮的样式
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    
    return self;
}

//设置placeholder的frame
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x + 30, bounds.origin.y, bounds.size.width - 10, bounds.size.height);//更好理解些
    
    return inset;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置左边图标的frame
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
}

@end
