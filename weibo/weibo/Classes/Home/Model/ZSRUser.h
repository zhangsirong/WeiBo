//
//  ZSRUser.h
//  weibo
//
//  Created by hp on 15/12/8.
//  Copyright © 2015年 hp. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

@interface ZSRUser : NSObject
/**	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;

/**	string	用户头像地址，50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;

@end
