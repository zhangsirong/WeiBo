//
//  ZSRConst.m
//  weibo
//
//  Created by hp on 15/12/17.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <Foundation/Foundation.h>
// 账号信息
NSString * const ZSRAppKey = @"3615446451";
NSString * const ZSRRedirectURI = @"https://www.baidu.com";
NSString * const ZSRAppSecret = @"6178adec639fa41e735db5568c3d3fad";
//@//api.weibo.com/oauth2/authorize?client_id=3615446451&redirect_uri=https://www.baidu.com"];
// 通知
// 表情选中的通知
NSString * const ZSREmotionDidSelectNotification = @"ZSREmotionDidSelectNotification";
NSString * const ZSRSelectEmotionKey = @"ZSRSelectEmotionKey";

// 删除文字的通知
NSString * const ZSREmotionDidDeleteNotification = @"ZSREmotionDidDeleteNotification";