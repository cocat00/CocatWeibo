//
//  CJSettingViewController.h
//  CocatWeibo
//
//  Created by chenjie on 4/27/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJSettingCell.h"

@class CJSettingGroup;

@interface CJSettingViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *groups;

- (CJSettingGroup *)addGroup;

@end
