//
//  ZSRLoadMoreFooter.m
//  weibo
//
//  Created by hp on 15/12/8.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRLoadMoreFooter.h"

@implementation ZSRLoadMoreFooter
+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZSRLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
