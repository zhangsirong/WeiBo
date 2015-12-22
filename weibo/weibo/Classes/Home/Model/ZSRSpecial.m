//
//  ZSRSpecial.m
//  weibo
//
//  Created by hp on 15/12/22.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRSpecial.h"

@implementation ZSRSpecial
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
