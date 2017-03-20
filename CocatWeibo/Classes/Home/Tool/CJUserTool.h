//
//  CJUserTool.h
//  CocatWeibo
//
//  Created by chenjie on 3/22/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJUserInfoParam.h"
#import "CJUserInfoResult.h"

#import "CJUserUnreadCountParam.h"
#import "CJUserUnreadCountResult.h"

@interface CJUserTool : NSObject

/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userInfoWithParam:(CJUserInfoParam *)param success:(void (^)(CJUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载用户的消息未读数
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userUnreadCountWithParam:(CJUserUnreadCountParam *)param success:(void (^)(CJUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;

@end
