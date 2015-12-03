//
//  ZSRHomeViewController.m
//  weibo
//
//  Created by hp on 15/11/27.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRHomeViewController.h"
#import "ZSRSearchBar.h"
#import "ZSRDropdownMenu.h"
#import "ZSRTitleMenuViewController.h"

@interface ZSRHomeViewController ()<ZSRDropdownMenuDelegate>

@end

@implementation ZSRHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
     /* 中间的标题按钮 */
    //    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.width = 150;
    titleButton.height = 30;
//    titleButton.backgroundColor = ZSRRandomColor;
    self.navigationItem.titleView = titleButton;
    
    // 设置图片和文字
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
//        titleButton.imageView.backgroundColor = [UIColor redColor];
//        titleButton.titleLabel.backgroundColor = [UIColor blueColor];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    
    // 监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    // 如果图片的某个方向上不规则，比如有突起，那么这个方向就不能拉伸
    
    
    UIView *grayView = [[UIView alloc] init];
    grayView.width = 200;
    grayView.height = 70;
    grayView.x = 20;
    grayView.y = 30;
    grayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:grayView];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.width = 100;
    btn.x = 140;
    btn.y = 30;
    btn.height = 30;
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    [grayView addSubview:btn];


}

/**
 *  标题点击
 */
- (void)titleClick:(UIButton *)titleButton{
    
    // 1.创建下拉菜单
    ZSRDropdownMenu *menu = [ZSRDropdownMenu menu];
    menu.delegate = self;
    
    // 2.设置内容
    ZSRTitleMenuViewController *vc = [[ZSRTitleMenuViewController alloc] init];
    vc.view.height = 150;
    vc.view.width = 150;
    menu.contentController = vc;
    
    // 3.显示
    [menu showFrom:titleButton];
}

- (void)friendSearch
{
    NSLog(@"friendSearch");
}

- (void)pop
{
    NSLog(@"pop");
}

#pragma mark - HWDropdownMenuDelegate
/**
 *  下拉菜单被销毁了
 */
- (void)dropdownMenuDidDismiss:(ZSRDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
    // 让箭头向下
//    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

/**
 *  下拉菜单显示了
 */
- (void)dropdownMenuDidShow:(ZSRDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
    // 让箭头向上
//    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

@end
