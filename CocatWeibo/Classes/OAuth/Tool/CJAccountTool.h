//
//  CJAccountTool.h
//  CocatWeibo
//
//  Created by chenjie on 12/16/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJOAuthParam.h"
#import "CJOAuthResult.h"

@class CJAccount;

@interface CJAccountTool : NSObject

/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(CJAccount *)account;

/**
 *  返回存储的账号信息
 */
+ (CJAccount *)account;

@end
