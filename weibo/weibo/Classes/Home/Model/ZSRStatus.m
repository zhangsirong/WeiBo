//
//  ZSRStatus.m
//  weibo
//
//  Created by hp on 15/12/8.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRStatus.h"
#import "ZSRUser.h"
@implementation ZSRStatus
+ (instancetype)statusWithDict:(NSDictionary *)dict
{
    ZSRStatus *status = [[self alloc] init];
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    status.user = [ZSRUser userWithDict:dict[@"user"]];
    return status;
}
@end
