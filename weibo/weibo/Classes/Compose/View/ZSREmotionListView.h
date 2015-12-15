//
//  ZSREmotionListView.h
//  weibo
//
//  Created by hp on 15/12/13.
//  Copyright © 2015年 hp. All rights reserved.
//  表情键盘顶部的表情内容（显示所有表情的）

#import <UIKit/UIKit.h>

@interface ZSREmotionListView : UIView
/** 表情(里面存放的ZSREmotion模型) */
@property (nonatomic, strong) NSArray *emotions;

@end
