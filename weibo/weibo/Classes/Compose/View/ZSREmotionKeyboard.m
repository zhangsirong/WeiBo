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

@interface ZSREmotionKeyboard ()<ZSREmotionTabBarDelegate>
/** 表情内容 */
@property (nonatomic, weak) ZSREmotionListView *listView;
/** tabbar */
@property (nonatomic, weak) ZSREmotionTabBar *tabBar;
@end

@implementation ZSREmotionKeyboard
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.表情内容
        ZSREmotionListView *listView = [[ZSREmotionListView alloc] init];
        listView.backgroundColor = ZSRRandomColor;
        [self addSubview:listView];
        self.listView = listView;
        
        // 2.tabbar
        ZSREmotionTabBar *tabBar = [[ZSREmotionTabBar alloc] init];
        tabBar.backgroundColor = ZSRRandomColor;
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
    self.listView.x = self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.tabBar.y;
}

#pragma mark - ZSREmotionTabBarDelegate
- (void)emotionTabBar:(ZSREmotionTabBar *)tabBar didSelectButton:(ZSREmotionTabBarButtonType)buttonType
{
    switch (buttonType) {
        case ZSREmotionTabBarButtonTypeRecent: // 最近
            ZSRLog(@"最近");
            break;
            
        case ZSREmotionTabBarButtonTypeDefault: // 默认
            ZSRLog(@"默认");
            break;
            
        case ZSREmotionTabBarButtonTypeEmoji: // Emoji
            ZSRLog(@"Emoji");
            break;
            
        case ZSREmotionTabBarButtonTypeLxh: // Lxh
            ZSRLog(@"Lxh");
            break;
    }
}

@end
