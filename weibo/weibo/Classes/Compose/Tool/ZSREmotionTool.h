//
//  ZSREmotionTool.h
//  weibo
//
//  Created by hp on 15/12/17.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZSREmotion;

@interface ZSREmotionTool : NSObject
+ (void)addRecentEmotion:(ZSREmotion *)emotion;
+ (NSArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)lxhEmotions;
+ (NSArray *)emojiEmotions;

/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+ (ZSREmotion *)emotionWithChs:(NSString *)chs;
@end