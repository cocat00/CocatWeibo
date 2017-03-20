//
//  CJHomeStatusesParam.h
//  CocatWeibo
//
//  Created by chenjie on 3/21/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJBaseParam.h"

@interface CJHomeStatusesParam : CJBaseParam

/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 */
@property (nonatomic, assign) NSNumber *since_id;

/**
 *  若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property (nonatomic, assign) NSNumber *max_id;

/**
 *  单页返回的记录条数，最大不超过100，默认为20。
 */
@property (nonatomic, assign) NSNumber *count;

@end
