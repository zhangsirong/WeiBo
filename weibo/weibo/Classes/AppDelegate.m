//
//  AppDelegate.m
//  weibo
//
//  Created by hp on 15/11/27.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "AppDelegate.h"
#import "ZSRHomeViewController.h"
#import "ZSRMessageCenterViewController.h"
#import "ZSRDiscoverViewController.h"
#import "ZSRProfileViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //2.设置根控制器
    UITabBarController *tabbarVc = [[UITabBarController alloc] init];
    self.window.rootViewController = tabbarVc;
    
    //3.设置子控制器
    // 3.设置子控制器
    ZSRHomeViewController *home = [[ZSRHomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    ZSRMessageCenterViewController *messageCenter = [[ZSRMessageCenterViewController alloc] init];
    [self addChildVc:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    ZSRDiscoverViewController *discover = [[ZSRDiscoverViewController alloc] init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    ZSRProfileViewController *profile = [[ZSRProfileViewController alloc] init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    [tabbarVc addChildViewController:home];
    [tabbarVc addChildViewController:messageCenter];
    [tabbarVc addChildViewController:discover];
    [tabbarVc addChildViewController:profile];
    // 很多重复代码 ---> 将重复代码抽取到一个方法中
    // 1.相同的代码放到一个方法中
    // 2.不同的东西变成参数
    // 3.在使用到这段代码的这个地方调用方法， 传递参数

    //4.显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}


/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字和图片
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = ZSRColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    childVc.view.backgroundColor = ZSRRandomColor;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
