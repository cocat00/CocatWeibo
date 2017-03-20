//
//  CJSettingViewController.m
//  CocatWeibo
//
//  Created by chenjie on 4/27/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJSettingViewController.h"
#import "CJSettingItem.h"
#import "CJSettingArrowItem.h"
#import "CJSettingLabelItem.h"
#import "CJSettingSwitchItem.h"
#import "CJSettingGroup.h"

@interface CJSettingViewController ()

@end

@implementation CJSettingViewController

- (NSMutableArray *)groups
{
    if (_groups == nil)
    {
        _groups = [NSMutableArray array];
    }
    
    return _groups;
}

- (CJSettingGroup *)addGroup
{
    CJSettingGroup *group = [CJSettingGroup group];
    [self.groups addObject:group];
    return group;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = CJColor(226, 226, 226);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 0;
    if (iOS7)
    {
        self.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CJSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJSettingCell *cell = [CJSettingCell cellWithTableView:tableView];
    CJSettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - 代理
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    CJSettingGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CJSettingGroup *group = self.groups[section];
    return group.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 1.取出模型
    CJSettingGroup *group = self.groups[indexPath.section];
    CJSettingItem *item = group.items[indexPath.row];
    
    // 2.操作
    if (item.operation)
    {
        item.operation();
    }
    
    // 3.跳转
    if ([item isKindOfClass:[CJSettingArrowItem class]])
    {
        CJSettingArrowItem *arrowItem = (CJSettingArrowItem *)item;
        if (arrowItem.destVcClass)
        {
            UIViewController *destVc = [[arrowItem.destVcClass alloc] init];
            destVc.title = arrowItem.title;
            [self.navigationController pushViewController:destVc animated:YES];
        }
    }
}

@end