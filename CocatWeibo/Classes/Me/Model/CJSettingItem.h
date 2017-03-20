//
//  CJSettingItem.h
//  CocatWeibo
//
//  Created by chenjie on 4/27/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CJSettingItemOperation)();

@interface CJSettingItem : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *badgeValue;
@property (nonatomic, copy) CJSettingItemOperation operation;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)item;

@end
