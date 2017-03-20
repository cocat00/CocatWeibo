//
//  CJTabBar.m
//  CocatWeibo
//
//  Created by chenjie on 11/9/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJTabBar.h"
#import "CJTabBarButton.h"

@interface CJTabBar()

@property (nonatomic, strong) NSMutableArray *tabBarButtons;

@property (nonatomic, weak) CJTabBarButton *selectedButton;

@property (nonatomic, weak) UIButton *plusButton;

@end 

@implementation CJTabBar


- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil)
    {
        _tabBarButtons = [NSMutableArray array];
    }
    
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if (!iOS7)
        { // 非iOS7下,设置tabbar的背景
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        
        // 添加一个加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [self addSubview:plusButton];
        [plusButton addTarget:self action:@selector(plusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

        self.plusButton = plusButton;
    }
    
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    CJTabBarButton *button = [[CJTabBarButton alloc] init];
    [self addSubview:button];
    // 添加按钮到数组中
    [self.tabBarButtons addObject:button];
    
    // 2.设置数据
    button.item = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.默认选中第0个按钮
    if (self.tabBarButtons.count == 1)
    {
        [self buttonClick:button];
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)])
    {
        [self.delegate tabBar:self didSelectedButtonFrom:
         (int)self.selectedButton.tag to:(int)button.tag];
    }
    
    // 2.设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = (CJTabBarButton *)button;
}

- (void)plusButtonClicked:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarPlusButtonClicked:)])
    {
        [self.delegate tabBarPlusButtonClicked:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
    // 按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index < self.tabBarButtons.count; index++)
    {
        // 1.取出按钮
        CJTabBarButton *button = self.tabBarButtons[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        if (index > 1)
        {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}


@end
