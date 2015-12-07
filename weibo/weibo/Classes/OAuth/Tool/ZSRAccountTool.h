//
//  ZSRAccountTool.h
//  weibo
//
//  Created by hp on 15/12/7.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZSRAccount.h"
@interface ZSRAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(ZSRAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (ZSRAccount *)account;
@end
