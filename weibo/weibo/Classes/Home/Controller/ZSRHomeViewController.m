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
#import "AFNetworking.h"
#import "ZSRAccountTool.h"
#import "ZSRTitleButton.h"
#import "UIImageView+WebCache.h"
#import "ZSRUser.h"
#import "ZSRStatus.h"
#import "MJExtension.h"
#import "ZSRLoadMoreFooter.h"

@interface ZSRHomeViewController ()<ZSRDropdownMenuDelegate>
/**
 *  微博数组（里面放的都是微博字典，一个字典对象就代表一条微博）
 */
@property (nonatomic, strong) NSMutableArray *statuses;
@end

@implementation ZSRHomeViewController

- (NSMutableArray *)statuses
{
    if (!_statuses) {
        self.statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置导航栏内容
    [self setupNav];
    
    //获得用户信息
    [self setupUserInfo];
    
    // 集成下拉刷新控件
    [self setupDownRefresh];
    
    // 集成上拉刷新控件
    [self setupUpRefresh];
    


}

/**
 *  集成上拉刷新控件
 */
- (void)setupUpRefresh
{
    ZSRLoadMoreFooter *footer = [ZSRLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

/**
 *  集成刷新控件
 */
- (void)setupDownRefresh
{
    // 1.添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    // 只有用户通过手动下拉刷新，才会触发UIControlEventValueChanged事件
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    // 2.马上进入刷新状态(仅仅是显示刷新状态，并不会触发UIControlEventValueChanged事件)
    [control beginRefreshing];
    
    // 3.马上加载数据
    [self refreshStateChange:control];
}

/**
 *  UIRefreshControl进入刷新状态：加载最新的数据
 */
- (void)refreshStateChange:(UIRefreshControl *)control
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    ZSRAccount *account = [ZSRAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    ZSRStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatus.idstr;
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [ZSRStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
        
        // 结束刷新刷新
        [control endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZSRLog(@"请求失败-%@", error);
        
        // 结束刷新刷新
        [control endRefreshing];
    }];
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    ZSRAccount *account = [ZSRAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    ZSRStatus *lastStatus = [self.statuses lastObject];
    if (lastStatus) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatus.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [ZSRStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statuses addObjectsFromArray:newStatuses];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZSRLog(@"请求失败-%@", error);
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}


/**
 *  显示最新微博的数量
 *
 *  @param count 最新微博的数量
 */
- (void)showNewStatusCount:(int)count
{
    // 1.创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    // 2.设置其他属性
    if (count == 0) {
        label.text = @"没有新的微博数据，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据", count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    // 3.添加
    label.y = 64 - label.height;
    // 将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 4.动画
    // 先利用1s的时间，让label往下移动一段距离
    CGFloat duration = 1.0; // 动画的时间
    [UIView animateWithDuration:duration animations:^{
        //        label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        // 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
        CGFloat delay = 1.0; // 延迟1s
        // UIViewAnimationOptionCurveLinear:匀速
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            //            label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
    // 如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画
}

/**
 * 获得用户信息
 */
- (void)setupUserInfo
{
    
    // https://api.weibo.com/2/users/show.json
    // access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    // uid	false	int64	需要查询的用户ID。
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    ZSRAccount *account = [ZSRAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        ZSRLog(@"请求成功-%@", responseObject);

        // 标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        // 设置名字
        ZSRUser *user = [ZSRUser mj_objectWithKeyValues:responseObject];
//        NSString *name = responseObject[@"name"];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒中
        account.name = user.name;
        [ZSRAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZSRLog(@"请求失败-%@", error);
    }];

}
/**
 *  设置导航栏上面的内容
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    /* 中间的标题按钮 */
    ZSRTitleButton *titleButton = [[ZSRTitleButton alloc] init];
   // 设置图片和文字
    NSString *name = [ZSRAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];    // 监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
//    titleButton.backgroundColor = ZSRRandomColor;
    self.navigationItem.titleView = titleButton;
}
    // 如果图片的某个方向上不规则，比如有突起，那么这个方向就不能拉伸
    // 什么情况下建议使用imageEdgeInsets、titleEdgeInsets
    // 如果按钮内部的图片、文字固定，用这2个属性来设置间距，会比较简单
    // 标题宽度
    //    CGFloat titleW = titleButton.titleLabel.width * [UIScreen mainScreen].scale;
    ////    // 乘上scale系数，保证retina屏幕上的图片宽度是正确的
    //    CGFloat imageW = titleButton.imageView.width * [UIScreen mainScreen].scale;
    //    CGFloat left = titleW + imageW;
    //    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
    


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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statuses.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 取出这行对应的微博字典
    ZSRStatus *status = self.statuses[indexPath.row];

    // 取出这条微博的作者（用户）
    ZSRUser *user = status.user;
    cell.textLabel.text = user.name;
    // 设置微博的文字

    cell.detailTextLabel.text = status.text;
    // 设置头像
   
    UIImage *placehoder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placehoder];
    
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statuses.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
    
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}

@end

