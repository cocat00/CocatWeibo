//
//  CJOAuthTool.m
//  CocatWeibo
//
//  Created by chenjie on 3/23/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJOAuthTool.h"
#import "CJHttpTool.h"
#import "MJExtension.h"

@implementation CJOAuthTool

+ (void)oAuthInfoWithParam:(CJOAuthParam *)param success:(void (^)(CJOAuthResult *result))success failure:(void (^)(NSError *error))failure
{
    NSLog(@"params:%@", param.mj_keyValues);
    
    [CJHttpTool postWithURL:@"https://api.weibo.com/oauth2/access_token" params:param.mj_keyValues success:^(id json) {
        if (success) {
            CJOAuthResult *result = [CJOAuthResult mj_objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
