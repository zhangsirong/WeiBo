//
//  ZSRHomeViewController.m
//  weibo
//
//  Created by hp on 15/11/27.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRHomeViewController.h"
#import "ZSRSearchBar.h"
@interface ZSRHomeViewController ()

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
//        titleButton.imageView.backgroundColor = [UIColor redColor];
//        titleButton.titleLabel.backgroundColor = [UIColor blueColor];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    
    // 监听标题点击
    [titleButton addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    // 如果图片的某个方向上不规则，比如有突起，那么这个方向就不能拉伸

}

/**
 *  标题点击
 */
- (void)titleClick
{
    // 这样获得的窗口，是目前显示在屏幕最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 添加蒙板（用于拦截灰色图片外面的点击事件）
    UIView *cover = [[UIView alloc] init];
    cover.backgroundColor = [UIColor clearColor];
    cover.frame = window.bounds;
    [window addSubview:cover];
    
    // 添加带箭头的灰色图片
    UIImageView *dropdownMenu = [[UIImageView alloc] init];
    dropdownMenu.image = [UIImage imageNamed:@"popover_background"];
    dropdownMenu.width = 217;
    dropdownMenu.height = 217;
    dropdownMenu.y = 40;
    
    [dropdownMenu addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    
    [window addSubview:dropdownMenu];
    
    
    // self.view.window = [UIApplication sharedApplication].keyWindow
    // 建议使用[UIApplication sharedApplication].keyWindow获得窗口
    
    NSLog(@"%@", [UIApplication sharedApplication].windows);
}

- (void)friendSearch
{
    NSLog(@"friendSearch");
}

- (void)pop
{
    NSLog(@"pop");
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
