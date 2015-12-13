//
//  ZSREmotionTabBar.h
//  weibo
//
//  Created by hp on 15/12/13.
//  Copyright © 2015年 hp. All rights reserved.
//  表情键盘底部的选项卡

#import <UIKit/UIKit.h>
typedef enum {
    ZSREmotionTabBarButtonTypeRecent, // 最近
    ZSREmotionTabBarButtonTypeDefault, // 默认
    ZSREmotionTabBarButtonTypeEmoji, // emoji
    ZSREmotionTabBarButtonTypeLxh, // 浪小花
} ZSREmotionTabBarButtonType;

@class ZSREmotionTabBar;

@protocol ZSREmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(ZSREmotionTabBar *)tabBar didSelectButton:(ZSREmotionTabBarButtonType)buttonType;
@end

@interface ZSREmotionTabBar : UIView
@property (nonatomic, weak) id<ZSREmotionTabBarDelegate> delegate;
@end
