//
//  ZSREmotionAttachment.m
//  weibo
//
//  Created by hp on 15/12/16.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSREmotionAttachment.h"
#import "ZSREmotion.h"
@implementation ZSREmotionAttachment
- (void)setEmotion:(ZSREmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}
@end
