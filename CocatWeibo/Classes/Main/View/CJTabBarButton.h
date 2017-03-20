//
//  CJTabBarButton.h
//  CocatWeibo
//
//  Created by chenjie on 11/9/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import <UIKit/UIKit.h>

// 图标的比例
#define IWTabBarButtonImageRatio 0.6

// 按钮的默认文字颜色
#define  IWTabBarButtonTitleColor (iOS7 ? [UIColor blackColor] : [UIColor whiteColor])
// 按钮的选中文字颜色
#define  IWTabBarButtonTitleSelectedColor (iOS7 ? CJColor(234, 103, 7) : CJColor(248, 139, 0))

@interface CJTabBarButton : UIButton

@property (nonatomic, strong) UITabBarItem *item;

@end
