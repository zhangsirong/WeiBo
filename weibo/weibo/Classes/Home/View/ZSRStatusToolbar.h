//
//  ZSRStatusToolbar.h
//  weibo
//
//  Created by hp on 15/12/10.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZSRStatus;
@interface ZSRStatusToolbar : UIView
+ (instancetype)toolbar;
@property (nonatomic, strong) ZSRStatus *status;
@end
