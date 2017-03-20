//
//  CJStatusTool.h
//  CocatWeibo
//
//  Created by chenjie on 3/21/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJHomeStatusesParam.h"
#import "CJHomeStatusesResult.h"

@interface CJStatusTool : NSObject

+ (void)homeStatusesWithParam:(CJHomeStatusesParam *)param success:(void (^)(CJHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

@end
