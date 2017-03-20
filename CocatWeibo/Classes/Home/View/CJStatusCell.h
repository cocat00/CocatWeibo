//
//  CJStatusCell.h
//  CocatWeibo
//
//  Created by chenjie on 12/31/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJStatusFrame;

@interface CJStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) CJStatusFrame *statusFrame;

@end
