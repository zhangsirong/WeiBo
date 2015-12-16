//
//  ZSREmotionAttachment.h
//  weibo
//
//  Created by hp on 15/12/16.
//  Copyright © 2015年 hp. All rights reserved.
//


#import <UIKit/UIKit.h>
@class ZSREmotion;

@interface ZSREmotionAttachment : NSTextAttachment
@property (nonatomic, strong) ZSREmotion *emotion;
@end