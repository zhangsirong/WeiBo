//
//  ZSRNewfeatureViewController.m
//  weibo
//
//  Created by hp on 15/12/4.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRNewfeatureViewController.h"
#define ZSRNewfeatureCount 4
@interface ZSRNewfeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic , weak)UIPageControl *pageControl;

@end

@implementation ZSRNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     // 1.创建一个scrollView:显示所有图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    // 2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < ZSRNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        //显示图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
    }
    // 3.设置scrollView的其他属性
    // 如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
    scrollView.contentSize = CGSizeMake(ZSRNewfeatureCount * scrollW, 0);
    scrollView.bounces = NO; // 去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    // 4.添加pageControl：分页，展示目前看的是第几页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = ZSRNewfeatureCount;

    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;

    pageControl.currentPageIndicatorTintColor = ZSRColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = ZSRColor(189, 189, 189);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    // UIPageControl就算没有设置尺寸，里面的内容还是照常显示的
    // pageControl.width = 100;
    // pageControl.height = 50;
    // pageControl.userInteractionEnabled = NO;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
