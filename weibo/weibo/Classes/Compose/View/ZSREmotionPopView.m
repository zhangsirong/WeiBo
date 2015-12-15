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

- (void)setEmotion:(ZSREmotion *)emotion
{
    _emotion = emotion;
    
    self.emotionButton.emotion = emotion;
}

@end