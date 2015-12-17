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
@end