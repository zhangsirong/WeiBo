//
//  ZSRMessageCenterViewController.m
//  weibo
//
//  Created by hp on 15/11/27.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRMessageCenterViewController.h"
#import "ZSRTest1ViewController.h"


@interface ZSRMessageCenterViewController ()

@end

@implementation ZSRMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:(UIBarButtonItemStylePlain) target:self action:@selector(composeMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     // 这个item不能点击(目前放在viewWillAppear就能显示disable下的主题)
//    self.navigationItem.rightBarButtonItem.enabled = NO;

}
- (void)composeMsg{
    NSLog(@"composeMsg");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test-message-%ld", indexPath.row];
    
  
    return cell;
}
#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZSRTest1ViewController *test1 = [[ZSRTest1ViewController alloc] init];
    test1.title = @"Test1控制器";
    // 当test1控制器被push的时候，test1所在的tabbarcontroller的tabbar会自动隐藏
    // 当test1控制器被pop的时候，test1所在的tabbarcontroller的tabbar会自动显示
//    test1.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:test1 animated:YES];
    
}

@end
