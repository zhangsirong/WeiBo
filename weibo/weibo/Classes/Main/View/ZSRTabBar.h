//
//  ZSRTabBar.h
//  weibo
//
//  Created by hp on 15/12/3.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZSRTabBar;

#warning 因为HWTabBar继承自UITabBar，所以称为HWTabBar的代理，也必须实现UITabBar的代理协议
@protocol ZSRTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(ZSRTabBar *)tabBar;
@end

@interface ZSRTabBar : UITabBar
@property (nonatomic, weak) id<ZSRTabBarDelegate> delegate;
@end
