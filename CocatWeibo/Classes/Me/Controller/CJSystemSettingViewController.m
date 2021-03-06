//
//  CJSystemSettingViewController.m
//  CocatWeibo
//
//  Created by chenjie on 5/3/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJSystemSettingViewController.h"
#import "CJSettingItem.h"
#import "CJSettingArrowItem.h"
#import "CJSettingLabelItem.h"
#import "CJSettingSwitchItem.h"
#import "CJSettingGroup.h"
#import "CJGeneralViewController.h"

@interface CJSystemSettingViewController ()

@end

@implementation CJSystemSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"设置";
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    
    [self setupFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupFooter
{
    // 按钮
    UIButton *logoutButton = [[UIButton alloc] init];
    CGFloat logoutX = CJStatusTableBorder + 2;
    CGFloat logoutY = 10;
    CGFloat logoutW = self.tableView.frame.size.width - 2 * logoutX;
    CGFloat logoutH = 44;
    logoutButton.frame = CGRectMake(logoutX, logoutY, logoutW, logoutH);
    
    // 背景和文字
    [logoutButton setBackgroundImage:[UIImage resizedImageWithName:@"common_button_red"] forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage resizedImageWithName:@"common_button_red_highlighted"] forState:UIControlStateHighlighted];
    [logoutButton setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // footer
    UIView *footer = [[UIView alloc] init];
    CGFloat footerH = logoutH + 20;
    footer.frame = CGRectMake(0, 0, 0, footerH);
    self.tableView.tableFooterView = footer;
    [footer addSubview:logoutButton];
}

- (void)setupGroup0
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *account = [CJSettingArrowItem itemWithTitle:@"帐号管理"];
    group.items = @[account];
}

- (void)setupGroup1
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *theme = [CJSettingArrowItem itemWithTitle:@"主题、背景" destVcClass:nil];
    group.items = @[theme];
}

- (void)setupGroup2
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *notice = [CJSettingArrowItem itemWithTitle:@"通知和提醒"];
    CJSettingArrowItem *general = [CJSettingArrowItem itemWithTitle:@"通用设置" destVcClass:[CJGeneralViewController class]];
    CJSettingArrowItem *safe = [CJSettingArrowItem itemWithTitle:@"隐私与安全"];
    
    CJSettingSwitchItem *switchItem = [CJSettingSwitchItem itemWithTitle:@"喵" switchOperation:^(BOOL isOn) {
        NSLog(@"isOn = %d", isOn);
    }];
    group.items = @[notice, general, safe, switchItem];
}

- (void)setupGroup3
{
    CJSettingGroup *group = [self addGroup];
    
    CJSettingArrowItem *opinion = [CJSettingArrowItem itemWithTitle:@"意见反馈"];
    CJSettingArrowItem *about = [CJSettingArrowItem itemWithTitle:@"关于微博"];
    group.items = @[opinion, about];
}


@end
