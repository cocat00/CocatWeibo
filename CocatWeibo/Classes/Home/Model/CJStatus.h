//
//  CJStatus.h
//  CocatWeibo
//
//  Created by chenjie on 12/17/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@class CJUser;

@interface CJStatus : NSObject

/**
 *  微博的内容(文字)
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  微博的配图(数组中装模型:IWPhoto)
 */
@property (nonatomic, strong) NSArray *pic_urls;

/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的表态数(被赞数)
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  微博的作者
 */
@property (nonatomic, strong) CJUser *user;

/**
 *  被转发的微博
 */
@property (nonatomic, strong) CJStatus *retweeted_status;

@end
