//
//  ZSRStatusFrame.h
//  weibo
//
//  Created by hp on 15/12/9.
//  Copyright © 2015年 hp. All rights reserved.
//  一个ZSRStatusFrame模型里面包含的信息
//  1.存放着一个cell内部所有子控件的frame数据
//  2.存放一个cell的高度
//  3.存放着一个数据模型ZSRStatus

#import <Foundation/Foundation.h>

// 昵称字体
#define ZSRStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define ZSRStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define ZSRStatusCellSourceFont ZSRStatusCellTimeFont
// 正文字体
#define ZSRStatusCellContentFont [UIFont systemFontOfSize:14]


@class ZSRStatus;
@interface ZSRStatusFrame : NSObject

@property (nonatomic, strong) ZSRStatus *status;
/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotoViewF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
