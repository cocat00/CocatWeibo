//
//  CJHomeStatusesResult.m
//  CocatWeibo
//
//  Created by chenjie on 3/22/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJHomeStatusesResult.h"
#import "CJStatus.h"
#import "MJExtension.h"

@implementation CJHomeStatusesResult

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"statuses" : [CJStatus class]};
}

@end
