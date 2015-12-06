//
//  ZSRAccount.h
//  weibo
//
//  Created by hp on 15/12/6.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSRAccount : NSObject<NSCoding>
/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/**　string	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSNumber *expires_in;

/**　string	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
