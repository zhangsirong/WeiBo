//
//  ZSRAccountTool.m
//  weibo
//
//  Created by hp on 15/12/7.
//  Copyright © 2015年 hp. All rights reserved.
//

// 账号的存储路径
#define ZSRAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]


#import "ZSRAccountTool.h"
#import "ZSRAccount.h"
@implementation ZSRAccountTool


/**
 *  存储账号
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(ZSRAccount *)account
{
    //获得账号存储的时间（accessToken的产生时间)
    account.created_time = [NSDate date];
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:ZSRAccountPath];
}

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (ZSRAccount *)account
{
    
    //加载模型
    ZSRAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ZSRAccountPath];
    
    //验证账号是否过期
    
    //过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    
    //获得过期时间
    NSDate *expiresTime =  [account.created_time dateByAddingTimeInterval:expires_in];
    
    //获得当前时间
    NSDate *now = [NSDate date];
        ZSRLog(@"%@,%@",expiresTime , now);
    //如果expiresTime <= now   过期
    /**
     NSOrderedAscending = -1L,
     NSOrderedSame
     NSOrderedDescending
     */
    
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {//过期
        return nil;
    }

    return account;
}
@end
