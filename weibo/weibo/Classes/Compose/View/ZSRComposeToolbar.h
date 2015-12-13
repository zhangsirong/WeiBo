//
//  ZSRComposeToolbar.h
//  weibo
//
//  Created by hp on 15/12/12.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    ZSRComposeToolbarButtonTypeCamera, // 拍照
    ZSRComposeToolbarButtonTypePicture, // 相册
    ZSRComposeToolbarButtonTypeMention, // @
    ZSRComposeToolbarButtonTypeTrend, // #
    ZSRComposeToolbarButtonTypeEmotion // 表情
} ZSRComposeToolbarButtonType;
@class ZSRComposeToolbar;

@protocol ZSRComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(ZSRComposeToolbar *)toolbar didClickButton:(ZSRComposeToolbarButtonType)buttonType;
@end

@interface ZSRComposeToolbar : UIView
@property (nonatomic, weak) id<ZSRComposeToolbarDelegate> delegate;
@end
