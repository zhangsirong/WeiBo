//
//  ZSREmotionKeyboard.m
//  weibo
//
//  Created by hp on 15/12/13.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSREmotionKeyboard.h"
#import "ZSREmotionListView.h"
#import "ZSREmotionTabBar.h"
#import "ZSREmotion.h"
#import "ZSREmotionTool.h"
#import "MJExtension.h"

@interface ZSREmotionKeyboard ()<ZSREmotionTabBarDelegate>
/** 保存正在显示listView */
@property (nonatomic, weak) ZSREmotionListView *showingListView;
/** 表情内容 */
@property (nonatomic, strong) ZSREmotionListView *recentListView;
@property (nonatomic, strong) ZSREmotionListView *defaultListView;
@property (nonatomic, strong) ZSREmotionListView *emojiListView;
@property (nonatomic, strong) ZSREmotionListView *lxhListView;
/** tabbar */
@property (nonatomic, weak) ZSREmotionTabBar *tabBar;
@end

@implementation ZSREmotionKeyboard
#pragma mark - 懒加载

- (ZSREmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[ZSREmotionListView alloc] init];
        // 加载沙盒中的数据
        self.recentListView.emotions = [ZSREmotionTool recentEmotions];
    }
    return _recentListView;
}

- (ZSREmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[ZSREmotionListView alloc] init];
        self.defaultListView.emotions = [ZSREmotionTool defaultEmotions];
    }
    return _defaultListView;
}

- (ZSREmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[ZSREmotionListView alloc] init];
        self.emojiListView.emotions = [ZSREmotionTool emojiEmotions];
    }
    return _emojiListView;
}

- (ZSREmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[ZSREmotionListView alloc] init];
        self.lxhListView.emotions = [ZSREmotionTool lxhEmotions];
    }
    return _lxhListView;
}
#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // tabbar
        ZSREmotionTabBar *tabBar = [[ZSREmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        // 表情选中的通知
        [ZSRNotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:ZSREmotionDidSelectNotification object:nil];
    }
    return self;
}

- (void)emotionDidSelect
{
    self.recentListView.emotions = [ZSREmotionTool recentEmotions];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    // 2.表情内容
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
}

#pragma mark - ZSREmotionTabBarDelegate
- (void)emotionTabBar:(ZSREmotionTabBar *)tabBar didSelectButton:(ZSREmotionTabBarButtonType)buttonType
{
    // 移除正在显示的listView控件
    [self.showingListView removeFromSuperview];
    switch (buttonType) {
        case ZSREmotionTabBarButtonTypeRecent: // 最近
 //             加载沙盒中的数据
//             self.recentListView.emotions = [ZSREmotionTool recentEmotions];
            
            [self addSubview:self.recentListView];
            break;
            
        case ZSREmotionTabBarButtonTypeDefault: // 默认
            [self addSubview:self.defaultListView];
            break;
            
        case ZSREmotionTabBarButtonTypeEmoji: // Emoji
            [self addSubview:self.emojiListView];
            break;
            
        case ZSREmotionTabBarButtonTypeLxh: // Lxh
            [self addSubview:self.lxhListView];
            break;
    }
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 设置frame
    [self setNeedsLayout];
}
@end
