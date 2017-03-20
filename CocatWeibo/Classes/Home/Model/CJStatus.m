//
//  CJStatus.m
//  CocatWeibo
//
//  Created by chenjie on 12/17/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJStatus.h"
#import "NSDate+CJ.h"
#import "MJExtension.h"
#import "CJPhoto.h"

@implementation CJStatus

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : [CJPhoto class]};
}

- (NSString *)created_at
{
    // _created_at == Fri May 09 16:30:34 +0800 2014
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
#warning 真机调试下，必须加上这段
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [fmt dateFromString:_created_at];
    // 2..判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday)
    { // 今天
        if (createdDate.deltaWithNow.hour > 1)
        {
            return [NSString stringWithFormat:@"%ld小时前", (long)createdDate.deltaWithNow.hour - 1];
        }
        else if (createdDate.deltaWithNow.minute > 1)
        {
            return [NSString stringWithFormat:@"%ld分钟前", (long)createdDate.deltaWithNow.minute - 1];
        }
        else
        {
            return @"刚刚";
        }
    }
    else if (createdDate.isYesterday)
    {
        // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    else if (createdDate.isThisYear)
    {
        // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    else
    {
        // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}

- (void)setSource:(NSString *)source
{
//    CJLog(@"source = %@", source);

    if ([source containsString:@">"] && [source containsString:@"</"])
    {
        NSUInteger location = [source rangeOfString:@">"].location + 1;
        NSUInteger length = [source rangeOfString:@"</"].location - location;
        source = [source substringWithRange:NSMakeRange(location, length)];
    }
    
    _source = source;
    
}

MJCodingImplementation

@end
