//
//  CJSettingGroup.h
//  CocatWeibo
//
//  Created by chenjie on 4/27/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJSettingGroup : NSObject

@property (copy, nonatomic) NSString *header;
@property (copy, nonatomic) NSString *footer;
@property (strong, nonatomic) NSArray *items;

+ (instancetype)group;

@end
