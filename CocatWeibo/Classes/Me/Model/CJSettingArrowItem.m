//
//  CJSettingArrowItem.m
//  CocatWeibo
//
//  Created by chenjie on 4/27/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJSettingArrowItem.h"

@implementation CJSettingArrowItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    CJSettingArrowItem *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}

@end
