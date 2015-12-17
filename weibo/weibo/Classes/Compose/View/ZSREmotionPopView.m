//
//  ZSREmotionPopView.m
//  weibo
//
//  Created by hp on 15/12/15.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSREmotionPopView.h"
#import "ZSREmotion.h"
#import "ZSREmotionButton.h"

@interface ZSREmotionPopView()
@property (weak, nonatomic) IBOutlet ZSREmotionButton *emotionButton;
@end

@implementation ZSREmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZSREmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFrom:(ZSREmotionButton *)button
{
    if (button == nil) return;
    
    // 给popView传递数据
    self.emotionButton.emotion = button.emotion;
    
    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height; // 100
    self.centerX = CGRectGetMidX(btnFrame);
}
@end