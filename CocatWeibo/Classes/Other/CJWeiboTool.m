//
//  CJWeiboTool.m
//  CocatWeibo
//
//  Created by chenjie on 12/16/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJWeiboTool.h"
#import "CJTabBarViewController.h"
#import "CJNewfeatureController.h"
#import "AppDelegate.h"

@implementation CJWeiboTool

+ (void)chooseRootController
{
    NSString *key = @"CFBundleVersion";
    //从沙盒中取出版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([currentVersion isEqualToString:lastVersion])
    {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        appDelegate.window.rootViewController = [[CJTabBarViewController alloc] init];
    }
    else
    {
        appDelegate.window.rootViewController = [[CJNewfeatureController alloc] init];
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}

@end
