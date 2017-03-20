//
//  CJSettingSwitchItem.m
//  CocatWeibo
//
//  Created by chenjie on 4/27/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJSettingSwitchItem.h"

@implementation CJSettingSwitchItem

+ (instancetype)itemWithTitle:(NSString *)title switchOperation:(CJSettingSwitchOperation) switchOperation
{
    CJSettingSwitchItem *item = [CJSettingSwitchItem itemWithIcon:nil title:title];
    item.settingSwitchOperation = switchOperation;
    
    return item;
}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title switchOperation:(CJSettingSwitchOperation)switchOperation;
{
    CJSettingSwitchItem *item = [CJSettingSwitchItem itemWithIcon:icon title:title];
    item.settingSwitchOperation = switchOperation;
    
    return item;

}

@end
