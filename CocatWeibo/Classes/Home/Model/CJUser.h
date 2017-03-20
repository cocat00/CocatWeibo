//
//  CJUser.h
//  CocatWeibo
//
//  Created by chenjie on 12/17/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface CJUser : JSONModel

/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;

/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  会员类型 >2 为会员
 */
@property (nonatomic, assign) int mbtype;

@end
