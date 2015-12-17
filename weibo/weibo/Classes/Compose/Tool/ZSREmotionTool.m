//
//  ZSREmotionTool.m
//  weibo
//
//  Created by hp on 15/12/17.
//  Copyright © 2015年 hp. All rights reserved.
//

// 最近表情的存储路径
#define ZSRRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

#import "ZSREmotionTool.h"

@implementation ZSREmotionTool
static NSMutableArray *_recentEmotions;

+ (void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:ZSRRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

+ (void)addRecentEmotion:(ZSREmotion *)emotion
{
    // 删除重复的表情
    [_recentEmotions removeObject:emotion];
    
    // 将表情放到数组的最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:ZSRRecentEmotionsPath];
}

/**
 *  返回装着ZSREmotion模型的数组
 */
+ (NSArray *)recentEmotions
{
    return _recentEmotions;
}
// 加载沙盒中的表情数据
//    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
//    if (emotions == nil) {
//        emotions = [NSMutableArray array];
//    }

//    [emotions removeObject:emotion];
//    for (int i = 0; i<emotions.count; i++) {
//        ZSREmotion *e = emotions[i];
//
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
//            [emotions removeObject:e];
//            break;
//        }
//    }

//    for (ZSREmotion *e in emotions) {
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
//            [emotions removeObject:e];
//            break;
//        }
//    }
@end

