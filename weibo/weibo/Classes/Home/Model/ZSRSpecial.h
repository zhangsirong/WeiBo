//
//  ZSRSpecial.h
//  weibo
//
//  Created by hp on 15/12/22.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSRSpecial : NSObject
/** 这段特殊文字的内容 */
@property (nonatomic, copy) NSString *text;
/** 这段特殊文字的范围 */
@property (nonatomic, assign) NSRange range;
@end
