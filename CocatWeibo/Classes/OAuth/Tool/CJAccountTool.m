//
//  CJAccountTool.m
//  CocatWeibo
//
//  Created by chenjie on 12/16/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJAccountTool.h"
#import "CJAccount.h"

#define kAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation CJAccountTool

/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */



+ (void)saveAccount:(CJAccount *)account
{
//    // 计算账号的过期时间
//    NSDate *now = [NSDate date];
//    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    //存储模型数据
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountPath];
}

/**
 *  返回存储的账号信息
 */
+ (CJAccount *)account
{
    CJAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountPath];
    
//    // 判断账号是否过期
//    NSDate *now = [NSDate date];
//    if ([now compare:account.expiresTime] == NSOrderedAscending)
//    { // 还没有过期
//        return account;
//    }
//    else
//    { // 过期
//        return nil;
//    }
    
    return account;
}

@end
