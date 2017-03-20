//
//  CJAccount.m
//  CocatWeibo
//
//  Created by chenjie on 12/15/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJAccount.h"

@implementation CJAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)accountWithOAuthResult:(CJOAuthResult *)result
{
    return  [[self alloc] initWithOAuthResult:result];
}

- (instancetype)initWithOAuthResult:(CJOAuthResult *)result
{
    if (self = [super init])
    {
        self.access_token = result.access_token;
        self.remind_in = [result.remind_in longLongValue];
        self.expires_in = [result.expires_in longLongValue];
        self.uid = [result.uid longLongValue];
    }
    return self;
}

/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.remind_in = [decoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [decoder decodeInt64ForKey:@"expires_in"];
        self.uid = [decoder decodeInt64ForKey:@"uid"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [encoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [encoder encodeInt64:self.uid forKey:@"uid"];
    [encoder encodeObject:self.name forKey:@"name"];
}

@end
