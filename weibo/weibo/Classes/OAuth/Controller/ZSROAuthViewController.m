//
//  ZSROAuthViewController.m
//  weibo
//
//  Created by hp on 15/12/5.
//  Copyright © 2015年 hp. All rights reserved.
//


#import "ZSROAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "ZSRAccountTool.h"

@interface ZSROAuthViewController ()<UIWebViewDelegate>

@end

@implementation ZSROAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.创建一个webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.用webView加载登录页面（新浪提供的）
    // 请求地址：https://api.weibo.com/oauth2/authorize
    /* 请求参数：
     client_id	true	string	申请应用时分配的AppKey。
     redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     */
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3615446451&redirect_uri=https://www.baidu.com"];
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    NSLog(@"------viewDidLoad");
}

#pragma mark - webView代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
    ZSRLog(@"------webViewDidFinishLoad");

}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    ZSRLog(@"------webViewDidStartLoad");
    [MBProgressHUD showMessage:@"正在加载..."];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.获得url
    NSString *url = request.URL.absoluteString;
    
    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { // 是回调地址
        // 截取code=后面的参数值
        int fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        ZSRLog(@"%@ %@",code,url);
        
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }
    
    return YES;
}

/**
 *  利用code（授权成功后的request token）换取一个accessToken
 *
 *  @param code 授权成功后的request token
 */
- (void)accessTokenWithCode:(NSString *)code
{
    /*
     URL：https://api.weibo.com/oauth2/access_token
     
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // AFN的AFJSONResponseSerializer默认不接受text/plain这种类型
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3615446451";
    params[@"client_secret"] = @"ceea8a46ccf52021258cae04e97760d3";//6178adec639fa41e735db5568c3d3fad
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"https://www.baidu.com";
    params[@"code"] = code;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUD];
        
         // 将返回的账号字典数据 --> 模型，存进沙盒
        ZSRAccount *account = [ZSRAccount accountWithDict:responseObject];
        //存储账号
        [ZSRAccountTool saveAccount:account];
        // 切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        ZSRLog(@"请求失败-%@",error);

    }];
}
@end
