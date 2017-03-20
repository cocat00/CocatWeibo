//
//  UIBarButtonItem+CJ.m
//  CocatWeibo
//
//  Created by chenjie on 11/24/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "UIBarButtonItem+CJ.h"

@implementation UIBarButtonItem (CJ)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [button setFrame:(CGRect){CGPointZero, button.currentBackgroundImage.size}];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
