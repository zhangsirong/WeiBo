//
//  ZSRDropdownMenu.h
//  weibo
//
//  Created by hp on 15/12/3.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSRDropdownMenu : UIView
+ (instancetype)menu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;

@end
