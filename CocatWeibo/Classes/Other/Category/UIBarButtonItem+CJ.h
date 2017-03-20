//
//  UIBarButtonItem+CJ.h
//  CocatWeibo
//
//  Created by chenjie on 11/24/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CJ)

/**
 *  快速创建一个显示图片的item
 *
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end
