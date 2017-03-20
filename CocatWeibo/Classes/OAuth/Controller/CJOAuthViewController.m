//
//  CJOAuthViewController.m
//  CocatWeibo
//
//  Created by chenjie on 12/15/15.
//  Copyright © 2015 atnv. All rights reserved.
//

#import "CJOAuthViewController.h"
#import "CJAccount.h"
#import "MBProgressHUD+CJ.h"
#import "CJWeiboTool.h"
#import "CJAccountTool.h"
#import "CJOAuthTool.h"

@interface CJOAuthViewController() <UIWebViewDelegate>

@end

@implementation CJOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.加载授权页面(新浪提供的登录页面)
    NSURLRequest *request = [NSURLRequest requestWithURL:CJLoginURL];
    [webView loadRequest:request];
}

#pragma mark - webView代理方法

/**
 *  webView开始发送请求的时候就会调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示提醒框
    [MBProgressHUD showMessage:@"哥正在帮你加载中..."];
}

/**
 *  webView请求完毕的时候就会调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

/**
 *  webView请求失败的时候就会调用
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

/**
 *  当webView发送一个请求之前都会先调用这个方法, 询问代理可不可以加载这个页面(请求)
 *
 *  @param request        request description
 *
 *  @return YES : 可以加载页面,  NO : 不可以加载页面
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.请求的URL路径: http://weibo.com/cocat/home?wvr=5&code=d98bdf7b5996d1e7f4e1129167dc7897
    NSString *urlStr = request.URL.absoluteString;
    
    // 2.查找code=在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 3.如果urlStr中包含了code=
    if (range.length)
    {
        // 4.截取code=后面的请求标记(经过用户授权成功的)
        NSUInteger loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
        // 5.发送POST请求给新浪,  通过code换取一个accessToken
        [self accessTokenWithCode:code];
        
        return NO;
    }
    
    return YES;
}

/**
 *  通过code换取一个accessToken
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.封装请求参数
    CJOAuthParam *param = [[CJOAuthParam alloc] init];
    param.client_id = CJClientId;
    param.client_secret = CJAppClientSecret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = CJRedirectURL;
    
    // 2.发送请求
    [CJOAuthTool oAuthInfoWithParam:param success:^(CJOAuthResult *result) {
        // 3.先将字典转为模型
        CJAccount *account = [CJAccount accountWithOAuthResult:result];
        
        // 4.存储模型数据
        [CJAccountTool saveAccount:account];
        
        // 5.新特性\去首页
        [CJWeiboTool chooseRootController];
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        CJLog(@"请求失败:%@", error);
        [MBProgressHUD hideHUD];
    }];
}

@end
