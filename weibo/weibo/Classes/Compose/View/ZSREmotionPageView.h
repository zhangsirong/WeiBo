//
//  ZSREmotionPageView.h
//  weibo
//
//  Created by hp on 15/12/15.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <UIKit/UIKit.h>
// 一页中最多3行
#define ZSREmotionMaxRows 3
// 一行中最多7列
#define ZSREmotionMaxCols 7
// 每一页的表情个数
#define ZSREmotionPageSize ((ZSREmotionMaxRows * ZSREmotionMaxCols) - 1)
@interface ZSREmotionPageView : UIView 
/** 这一页显示的表情（里面都是ZSREmotion模型） */
@property (nonatomic, strong) NSArray *emotions;
@end
