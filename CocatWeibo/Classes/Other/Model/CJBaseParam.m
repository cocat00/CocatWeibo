//
//  CJBaseParam.m
//  CocatWeibo
//
//  Created by chenjie on 3/22/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJBaseParam.h"
#import "CJAccount.h"
#import "CJAccountTool.h"

@implementation CJBaseParam

- (id)init
{
    if (self = [super init]) {
        self.access_token = [CJAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}

//- (NSString *)access_token
//{
//    if (_access_token == nil) {
//        self.access_token = [IWAccountTool account].access_token;
//    }
//    return _access_token;
//}

@end
