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
#import "MJExtension.h"

@interface ZSREmotionKeyboard ()<ZSREmotionTabBarDelegate>
/** 容纳表情内容的控件 */
@property (nonatomic, weak) UIView *contentView;
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
        self.recentListView.backgroundColor = ZSRRandomColor;
    }
    return _recentListView;
}

- (ZSREmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[ZSREmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultListView.emotions = [ZSREmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.defaultListView.backgroundColor = ZSRRandomColor;
    }
    return _defaultListView;
}

- (ZSREmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[ZSREmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [ZSREmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.emojiListView.backgroundColor = ZSRRandomColor;
    }
    return _emojiListView;
}

- (ZSREmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[ZSREmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [ZSREmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.lxhListView.backgroundColor = ZSRRandomColor;
    }
    return _lxhListView;
}
#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.contentView
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        // 2.tabbar
        ZSREmotionTabBar *tabBar = [[ZSREmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
    }
    return self;
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
    self.contentView.x = self.contentView.y = 0;
    self.contentView.width = self.width;
    self.contentView.height = self.tabBar.y;
}

#pragma mark - ZSREmotionTabBarDelegate
- (void)emotionTabBar:(ZSREmotionTabBar *)tabBar didSelectButton:(ZSREmotionTabBarButtonType)buttonType
{
    // 移除contentView之前显示的控件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (buttonType) {
        case ZSREmotionTabBarButtonTypeRecent: // 最近
            [self.contentView addSubview:self.recentListView];
            ZSRLog(@"最近");
            break;
            
        case ZSREmotionTabBarButtonTypeDefault: // 默认
            [self.contentView addSubview:self.defaultListView];
            ZSRLog(@"默认");
            break;
            
        case ZSREmotionTabBarButtonTypeEmoji: // Emoji
            [self.contentView addSubview:self.emojiListView];
            ZSRLog(@"Emoji");
            break;
            
        case ZSREmotionTabBarButtonTypeLxh: // Lxh
            [self.contentView addSubview:self.lxhListView];
            ZSRLog(@"Lxh");
            break;
    }
    // 重新计算子控件的frame(setNeedsLayout内部会在恰当的时刻，重新调用layoutSubviews，重新布局子控件)
    [self setNeedsLayout];
    //    UIView *child = [self.contentView.subviews lastObject];
    //    child.frame = self.contentView.bounds;
}
@end
