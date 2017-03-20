//
//  CJOAuthResult.h
//  CocatWeibo
//
//  Created by chenjie on 3/23/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJOAuthResult : NSObject

/**
 *  用于调用access_token，接口获取授权后的access token
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  access_token的生命周期，单位是秒数
 */
@property (nonatomic, copy) NSString *expires_in;

/**
 *  access_token的生命周期（该参数即将废弃，开发者请使用expires_in）
 */
@property (nonatomic, copy) NSString *remind_in;

/**
 *  当前授权用户的UID
 */
@property (nonatomic, copy) NSString *uid;

@end