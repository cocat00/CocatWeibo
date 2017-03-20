//
//  CJSettingCell.h
//  CocatWeibo
//
//  Created by chenjie on 4/27/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJSettingItem;

@interface CJSettingCell : UITableViewCell

@property (strong, nonatomic) CJSettingItem *item;

@property (strong, nonatomic) NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
