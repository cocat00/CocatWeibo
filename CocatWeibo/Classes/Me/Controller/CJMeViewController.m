//
//  CJMeViewController.m
//  CocatWeibo
//
//  Created by chenjie on 11/9/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJMeViewController.h"
#import "CJSettingItem.h"
#import "CJSettingArrowItem.h"
#import "CJSettingLabelItem.h"
#import "CJSettingSwitchItem.h"
#import "CJSettingGroup.h"
#import "CJSystemSettingViewController.h"

@interface CJMeViewController ()

@end

@implementation CJMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting:)];
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
}

- (void)setting:(id)sender
{
    CJSystemSettingViewController *viewController = [[CJSystemSettingViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)setupGroup0
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *newFriend = [CJSettingArrowItem itemWithIcon:@"new_friend" title:@"新的好友" destVcClass:nil];
    newFriend.badgeValue = @"10";
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *albumItem = [CJSettingArrowItem itemWithIcon:@"album" title:@"我的相册" destVcClass:nil];
    albumItem.subtitle = @"(109)";
    
    CJSettingArrowItem *collectItem = [CJSettingArrowItem itemWithIcon:@"collect" title:@"我的收藏" destVcClass:nil];
    collectItem.subtitle = @"(109)";
    
    CJSettingArrowItem *likeItem = [CJSettingArrowItem itemWithIcon:@"like" title:@"赞" destVcClass:nil];
    likeItem.subtitle = @"(109)";
    likeItem.badgeValue = @"100";
    
    group.items = @[albumItem, collectItem, likeItem];
}

- (void)setupGroup2
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *pay = [CJSettingArrowItem itemWithIcon:@"pay" title:@"微博支付" destVcClass:nil];
    CJSettingArrowItem *vip = [CJSettingArrowItem itemWithIcon:@"vip" title:@"会员中心" destVcClass:nil];
    group.items = @[pay, vip];
}

- (void)setupGroup3
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *card = [CJSettingArrowItem itemWithIcon:@"card" title:@"我的名片" destVcClass:nil];
    CJSettingArrowItem *draft = [CJSettingArrowItem itemWithIcon:@"draft" title:@"草稿箱" destVcClass:nil];
    group.items = @[card, draft];
}

@end
