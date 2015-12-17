//
//  ZSRHttpTool.h
//  weibo
//
//  Created by hp on 15/12/17.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSRHttpTool : NSObject
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
