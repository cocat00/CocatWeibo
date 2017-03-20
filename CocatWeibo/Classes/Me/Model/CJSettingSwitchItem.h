//
//  CJSettingSwitchItem.h
//  CocatWeibo
//
//  Created by chenjie on 4/27/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJSettingItem.h"

typedef void(^CJSettingSwitchOperation)(BOOL isOn);

@interface CJSettingSwitchItem : CJSettingItem

@property (strong, nonatomic) CJSettingSwitchOperation settingSwitchOperation;

+ (instancetype)itemWithTitle:(NSString *)title switchOperation:(CJSettingSwitchOperation)switchOperation;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title switchOperation:(CJSettingSwitchOperation)switchOperation;


@end
