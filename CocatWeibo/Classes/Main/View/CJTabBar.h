//
//  CJTabBar.h
//  CocatWeibo
//
//  Created by chenjie on 11/9/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJTabBar;

@protocol CJTabBarDelegate <NSObject>

@optional
- (void)tabBar:(CJTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

- (void)tabBarPlusButtonClicked:(CJTabBar *)tabBar;

@end

@interface CJTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<CJTabBarDelegate> delegate;

@end
