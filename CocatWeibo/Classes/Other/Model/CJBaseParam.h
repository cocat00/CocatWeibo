//
//  CJBaseParam.h
//  CocatWeibo
//
//  Created by chenjie on 3/22/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJBaseParam : NSObject

/**
 *  采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得
 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;

@end
