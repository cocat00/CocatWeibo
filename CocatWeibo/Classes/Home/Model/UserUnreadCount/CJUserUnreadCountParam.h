//
//  CJUserUnreadCountParam.h
//  CocatWeibo
//
//  Created by chenjie on 3/24/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJBaseParam.h"

@interface CJUserUnreadCountParam : CJBaseParam

/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;

@end
