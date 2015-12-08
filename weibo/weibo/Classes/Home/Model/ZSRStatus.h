//
//  ZSRStatus.h
//  weibo
//
//  Created by hp on 15/12/8.
//  Copyright © 2015年 hp. All rights reserved.
//  微博模型

#import <Foundation/Foundation.h>

@class ZSRUser;

@interface ZSRStatus : NSObject
/**	string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	微博信息内容*/
@property (nonatomic, copy) NSString *text;

/**	object	微博作者的用户信息字段 详细*/
@property (nonatomic, strong) ZSRUser *user;


@end
