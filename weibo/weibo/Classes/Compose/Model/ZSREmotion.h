//
//  ZSREmotion.h
//  weibo
//
//  Created by hp on 15/12/14.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSREmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的16进制编码 */
@property (nonatomic, copy) NSString *code;
@end
