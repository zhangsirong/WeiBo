//
//  ZSRTextView.h
//  weibo
//
//  Created by hp on 15/12/12.
//  Copyright © 2015年 hp. All rights reserved.
// 增强：带有占位文字

#import <UIKit/UIKit.h>

@interface ZSRTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
