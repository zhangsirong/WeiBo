//
//  ZSREmotionPopView.h
//  weibo
//
//  Created by hp on 15/12/15.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZSREmotion,ZSREmotionButton;
@interface ZSREmotionPopView : UIView
+ (instancetype)popView;
- (void)showFrom:(ZSREmotionButton *)button;
@end
