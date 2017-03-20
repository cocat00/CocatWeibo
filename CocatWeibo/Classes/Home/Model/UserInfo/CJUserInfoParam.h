//
//  CJUserInfoParam.h
//  CocatWeibo
//
//  Created by chenjie on 3/22/16.
//  Copyright © 2016 atnv. All rights reserved.
//  封装加载用户信息的参数

#import <Foundation/Foundation.h>
#import "CJBaseParam.h"

@interface CJUserInfoParam : CJBaseParam

/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;

/**
 *  需要查询的用户昵称。
 */
@property (nonatomic, copy) NSString *screen_name;

@end
