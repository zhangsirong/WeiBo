//
//  ZSREmotionPageView.m
//  weibo
//
//  Created by hp on 15/12/15.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSREmotionPageView.h"
#import "ZSREmotion.h"
#import "ZSREmotionPopView.h"
#import "ZSREmotionButton.h"

@interface ZSREmotionPageView ()
/** 点击表情后弹出的放大镜 */
@property (nonatomic, strong) ZSREmotionPopView *popView;
/** 删除按钮 */
@property (nonatomic, weak) UIButton *deleteButton;
@end


@implementation ZSREmotionPageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
    }
    return self;
}
- (ZSREmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [ZSREmotionPopView popView];
    }
    return _popView;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i<count; i++) {
        ZSREmotionButton *btn = [[ZSREmotionButton alloc] init];
        [self addSubview:btn];
        
        // 设置表情数据
        btn.emotion = emotions[i];
        
        // 监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
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
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i%ZSREmotionMaxCols) * btnW;
        btn.y = inset + (i/ZSREmotionMaxCols) * btnH;
    }
    // 删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.y = self.height - btnH;
    self.deleteButton.x = self.width - inset - btnW;
}

/**
 *  监听删除按钮点击
 */
- (void)deleteClick
{
    ZSRLog(@"deleteClick");
}

/**
 *  监听表情按钮点击
 *
 *  @param btn 被点击的表情按钮
 */
- (void)btnClick:(ZSREmotionButton *)btn
{
    // 给popView传递数据
    self.popView.emotion = btn.emotion;
    
    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.popView];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
    self.popView.centerX = CGRectGetMidX(btnFrame);
    //等会popView会消失掉
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    // 发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[ZSRSelectEmotionKey] = btn.emotion;
    [ZSRNotificationCenter postNotificationName:ZSREmotionDidSelectNotification object:nil userInfo:userInfo];
}
@end

