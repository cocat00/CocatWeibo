//
//  CJNewfeatureController.m
//  CocatWeibo
//
//  Created by chenjie on 12/10/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJNewfeatureController.h"
#import "CJTabBarViewController.h"

#define CJNewfeatureImageCount 3

@interface CJNewfeatureController()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation CJNewfeatureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupScrollView];
    
    [self setupPageControl];
}

/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    
    for (int index = 0; index < CJNewfeatureImageCount; index++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        NSString *name;
        
        if (FourInch)
        {
            name = [NSString stringWithFormat:@"new_feature_%d-568h", index + 1];
        }
        else
        {
            name = [NSString stringWithFormat:@"new_feature_%d", index + 1];
        }
        imageView.image = [UIImage imageWithName:name];
        
        // 设置frame
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        // 在最后一个图片上面添加按钮
        if (index == CJNewfeatureImageCount - 1)
        {
            [self setupLastImageView:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(imageW * CJNewfeatureImageCount, imageH);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
}

- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = CJNewfeatureImageCount;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = CJColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = CJColor(189, 189, 189);
}

/**
 *  添加内容到最后一个图片
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 2.设置frame
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    
    // 3.设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    // 4.添加checkbox
    UIButton *checkbox = [[UIButton alloc] init];
    checkbox.selected = YES;
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.bounds = CGRectMake(0, 0, 200, 50);
    CGFloat checkboxCenterX = centerX;
    CGFloat checkboxCenterY = imageView.frame.size.height * 0.5;
    checkbox.center = CGPointMake(checkboxCenterX, checkboxCenterY);
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    checkbox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [imageView addSubview:checkbox];
}

/**
 *  开始微博
 */
- (void)start
{
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    NSString *key = @"CFBundleVersion";

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    [defaults setObject:currentVersion forKey:key];
    [defaults synchronize];
    
    // 切换窗口的根控制器
    self.view.window.rootViewController = [[CJTabBarViewController alloc] init];
}

- (void)checkboxClick:(UIButton *)checkbox
{
    checkbox.selected = !checkbox.isSelected;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
    
}

@end
