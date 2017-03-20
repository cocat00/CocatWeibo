//
//  CJStatusTool.m
//  CocatWeibo
//
//  Created by chenjie on 3/21/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJStatusTool.h"
#import "MJExtension.h"
#import "CJHttpTool.h"
#import "CJStatusCacheTool.h"
#import "CJStatus.h"

@implementation CJStatusTool

+ (void)homeStatusesWithParam:(CJHomeStatusesParam *)param success:(void (^)(CJHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure
{
    NSLog(@"params:%@", param.mj_keyValues);
    
    //先从缓存里面加载
    NSArray *dictArray = [CJStatusCacheTool statusWithParam:param];
    /*有缓存*/
    if ([dictArray count] > 0)
    {
        // 传递了block
        if (success)
        {
            CJHomeStatusesResult *result = [[CJHomeStatusesResult alloc] init];
            result.statuses = [CJStatus mj_objectArrayWithKeyValuesArray:dictArray];
            success(result);
        }
    }
    else
    {
        [CJHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.mj_keyValues success:^(id json) {
            //缓存
            
            CJHomeStatusesResult *result = [CJHomeStatusesResult mj_objectWithKeyValues:json];

            [CJStatusCacheTool addStatuses:result.statuses];
            
            if (success)
            {
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure)
            {
                failure(error);
            }
        }];
    }
}

@end
