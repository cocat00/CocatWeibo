//
//  CJTabBarViewController.m
//  CocatWeibo
//
//  Created by chenjie on 11/19/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJTabBarViewController.h"
#import "CJHomeViewController.h"
#import "CJMessageViewController.h"
#import "CJMeViewController.h"
#import "CJDiscoverViewController.h"
#import "CJTabBar.h"
#import "CJNavigationViewController.h"
#import "CJComposeViewController.h"
#import "CJUserTool.h"
#import "CJAccountTool.h"
#import "CJAccount.h"


@interface CJTabBarViewController ()<CJTabBarDelegate>

/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) CJTabBar *customTabBar;

@property (nonatomic, strong) CJHomeViewController *home;

@property (nonatomic, strong) CJMessageViewController *message;

@property (nonatomic, strong) CJDiscoverViewController *discover;

@property (nonatomic, strong) CJMeViewController *me;

@end

@implementation CJTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTabbar];
    
    [self setupAllChildViewControllers];
    
    // 定时检查未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    //在子线程中执行timer
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  定时检查未读数
 */
- (void)checkUnreadCount
{
    // 1.请求参数
    CJUserUnreadCountParam *param = [CJUserUnreadCountParam param];
    param.uid = @([CJAccountTool account].uid);
    
    // 2.发送请求
    [CJUserTool userUnreadCountWithParam:param success:^(CJUserUnreadCountResult *result) {
        // 3.设置badgeValue
        // 3.1.首页
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        
        // 3.2.消息
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        
        // 3.3.我
        self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        
        // 4.设置图标右上角的数字
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.count;
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}
/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    CJTabBar *customTabBar = [[CJTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.首页
    CJHomeViewController *home = [[CJHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    
    // 2.消息
    CJMessageViewController *message = [[CJMessageViewController alloc] init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    // 3.广场
    CJDiscoverViewController *discover = [[CJDiscoverViewController alloc] init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    self.discover = discover;
    
    // 4.我
    CJMeViewController *me = [[CJMeViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.me = me;
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (iOS7)
    {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    else
    {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2.包装一个导航控制器
    CJNavigationViewController *nav = [[CJNavigationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

#pragma mark - CJTabBarDelegate
- (void)tabBar:(CJTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
    
    if (to == 0)
    {
        [self.home refresh];
    }
}

- (void)tabBarPlusButtonClicked:(CJTabBar *)tabBar
{
    CJComposeViewController *composeViewController = [[CJComposeViewController alloc] init];
    CJNavigationViewController *navigationViewController = [[CJNavigationViewController alloc] initWithRootViewController:composeViewController];
    [self presentViewController:navigationViewController animated:YES completion:nil];
}

@end
