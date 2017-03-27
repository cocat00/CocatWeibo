//
//  CJOAuthTool.h
//  CocatWeibo
//
//  Created by chenjie on 3/23/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJOAuthParam.h"
#import "CJOAuthResult.h"

@interface CJOAuthTool : NSObject


+ (void)oAuthInfoWithParam:(CJOAuthParam *)param success:(void (^)(CJOAuthResult *result))success failure:(void (^)(NSError *error))failure;

@end
