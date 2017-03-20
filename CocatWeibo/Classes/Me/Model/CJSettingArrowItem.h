//
//  CJSettingArrowItem.h
//  CocatWeibo
//
//  Created by chenjie on 4/27/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJSettingItem.h"

@interface CJSettingArrowItem : CJSettingItem

@property (assign, nonatomic) Class destVcClass;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;

@end
