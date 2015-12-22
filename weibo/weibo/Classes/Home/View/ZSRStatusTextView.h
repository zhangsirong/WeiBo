//
//  ZSRStatusTextView.h
//  weibo
//
//  Created by hp on 15/12/22.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSRStatusTextView : UITextView
/** 所有的特殊字符串(里面存放着HWSpecial) */
@property (nonatomic, strong) NSArray *specials;
@end
