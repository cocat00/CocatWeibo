//
//  CJCommon.h
//  CocatWeibo
//
//  Created by chenjie on 2/4/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#ifndef CJCommon_h
#define CJCommon_h


#define CJClientId         @"3870880903"
#define CJRedirectURL      @"http://weibo.com"
#define CJAppClientSecret  @"4bc79d8fb20f2b83270746ec693af8d9"
#define CJLoginURL         [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", CJClientId, CJRedirectURL]]

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)


// 2.获得RGB颜色
#define CJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.自定义Log
#ifdef DEBUG
#define CJLog(...) NSLog(__VA_ARGS__)
#else
#define CJLog(...)
#endif

// 4.是否为4inch
#define FourInch ([UIScreen mainScreen].bounds.size.height == 568.0)

// 5.微博cell上面的属性
/** 昵称的字体 */
#define CJStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define CJRetweetStatusNameFont CJStatusNameFont

/** 时间的字体 */
#define CJStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define CJStatusSourceFont CJStatusTimeFont

/** 中文的字体 */
#define CJStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define CJRetweetStatusContentFont CJStatusContentFont

/** 表格的边框宽度 */
#define CJStatusTableBorder 5

/** cell的边框宽度 */
#define CJStatusCellBorder 10

// 6.微博cell内部相册
#define CJPhotoW 70
#define CJPhotoH 70
#define CJPhotoMargin 10

// 7.常用的工具

#define CJNotificationCenter [NSNotificationCenter defaultCenter]


#endif /* CJCommon_h */
