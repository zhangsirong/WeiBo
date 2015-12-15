//
//  ZSREmotionPageView.m
//  weibo
//
//  Created by hp on 15/12/15.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSREmotionPageView.h"
#import "ZSREmotion.h"
@implementation ZSREmotionPageView
- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i<count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        ZSREmotion *emotion = emotions[i];
//        btn.backgroundColor = ZSRRandomColor;
        
        if (emotion.png) { // 有图片
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        } else if (emotion.code) { // 是emoji表情
            // 设置emoji
            [btn setTitle:emotion.code.emoji forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
        }
        
        [self addSubview:btn];
    }
}

// CUICatalog: Invalid asset name supplied: (null), or invalid scale factor: 2.000000
// 警告原因：尝试去加载的图片不存在

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 内边距(四周)
    CGFloat inset = 20;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / ZSREmotionMaxCols;
    CGFloat btnH = (self.height - inset) / ZSREmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i%ZSREmotionMaxCols) * btnW;
        btn.y = inset + (i/ZSREmotionMaxCols) * btnH;
    }
}
@end

