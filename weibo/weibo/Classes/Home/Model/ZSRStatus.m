//
//  ZSRStatus.m
//  weibo
//
//  Created by hp on 15/12/8.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRStatus.h"
#import "ZSRPhoto.h"

@implementation ZSRStatus

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : [ZSRPhoto class]};
}


@end
