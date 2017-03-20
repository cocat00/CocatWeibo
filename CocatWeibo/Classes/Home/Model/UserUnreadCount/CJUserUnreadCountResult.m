//
//  CJUserUnreadCountResult.m
//  CocatWeibo
//
//  Created by chenjie on 3/24/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJUserUnreadCountResult.h"

@implementation CJUserUnreadCountResult

- (int)messageCount
{
    return self.cmt + self.mention_cmt + self.mention_status + self.dm;
}

- (int)count
{
    return self.messageCount + self.status + self.follower;
}

@end
