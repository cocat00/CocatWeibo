//
//  CJUserTool.m
//  CocatWeibo
//
//  Created by chenjie on 3/22/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJUserTool.h"
#import "CJHttpTool.h"
#import "MJExtension.h"

@implementation CJUserTool

+ (void)userInfoWithParam:(CJUserInfoParam *)param success:(void (^)(CJUserInfoResult *result))success failure:(void (^)(NSError *error))failure
{
    NSLog(@"params:%@", param.mj_keyValues);
    
    [CJHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:param.mj_keyValues success:^(id json) {
        if (success) {
            CJUserInfoResult *result = [CJUserInfoResult mj_objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userUnreadCountWithParam:(CJUserUnreadCountParam *)param success:(void (^)(CJUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure
{
    [CJHttpTool getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:param.mj_keyValues success:^(id json) {
        if (success) {
            CJUserUnreadCountResult *result = [CJUserUnreadCountResult mj_objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
