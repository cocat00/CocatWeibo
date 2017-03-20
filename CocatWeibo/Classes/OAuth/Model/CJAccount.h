//
//  CJAccount.h
//  CocatWeibo
//
//  Created by chenjie on 12/15/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJOAuthResult.h"

@interface CJAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, strong) NSDate *expiresTime; // 账号的过期时间

// 如果服务器返回的数字很大, 建议用long long(比如主键, ID)
@property (nonatomic, assign) long long expires_in;

@property (nonatomic, assign) long long remind_in;

@property (nonatomic, assign) long long uid;

@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)accountWithOAuthResult:(CJOAuthResult *)result;

- (instancetype)initWithOAuthResult:(CJOAuthResult *)result;

@end
