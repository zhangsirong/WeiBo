//
//  ZSRUser.m
//  weibo
//
//  Created by hp on 15/12/8.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRUser.h"

@implementation ZSRUser
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

//- (BOOL)isVip
//{
//    return self.mbrank > 2;
//}
@end
