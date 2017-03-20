//
//  CJHomeStatusesResult.h
//  CocatWeibo
//
//  Created by chenjie on 3/22/16.
//  Copyright © 2016 atnv. All rights reserved.
//  封装加载首页微博数据的返回结果

#import <Foundation/Foundation.h>

@interface CJHomeStatusesResult : NSObject

/**
 *  statuses数组里面放的都是CJStatus模型
 */
@property (nonatomic, strong) NSArray *statuses;

@property (nonatomic, assign) long long previous_cursor;
@property (nonatomic, assign) long long next_cursor;

/**
 *  总数
 */
@property (nonatomic, assign) long long total_number;

@end
