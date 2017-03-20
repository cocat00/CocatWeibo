//
//  CJStatusCacheTool.h
//  CocatWeibo
//
//  Created by chenjie on 4/19/16.
//  Copyright © 2016 atnv. All rights reserved.
//  管理微博的缓存数据

#import <Foundation/Foundation.h>
#import "CJHomeStatusesParam.h"

@class CJStatus;

@interface CJStatusCacheTool : NSObject

/**
 *  缓存一条微博
 *
 *  @param dict 需要缓存的微博数据
 */
+ (void)addStatus:(CJStatus *)status;


/**
 *  缓存多条微博
 *
 *  @param dictArry 需要缓存的微博
 */
+ (void)addStatuses:(NSArray *)statusArry;

/**
 *  根据请求参数获得微博数据
 *
 *  @param param 请求参数
 *
 *  @return 字典数组
 */
+ (NSArray *)statusWithParam:(CJHomeStatusesParam *)param;


@end
