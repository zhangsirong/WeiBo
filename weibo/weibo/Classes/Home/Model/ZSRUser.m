//
//  ZSRUser.m
//  weibo
//
//  Created by hp on 15/12/8.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRUser.h"

@implementation ZSRUser
+ (instancetype)userWithDict:(NSDictionary *)dict
{
    ZSRUser *user = [[self alloc] init];
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    return user;
}
@end
