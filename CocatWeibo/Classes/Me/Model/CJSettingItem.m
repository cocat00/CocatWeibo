//
//  CJSettingItem.m
//  CocatWeibo
//
//  Created by chenjie on 4/27/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJSettingItem.h"

@implementation CJSettingItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    CJSettingItem *item = [self item];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

+ (instancetype)item
{
    return [[self alloc] init];
}

@end
