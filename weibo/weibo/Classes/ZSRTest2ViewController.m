//
//  ZSRTest2ViewController.m
//  weibo
//
//  Created by hp on 15/11/28.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRTest2ViewController.h"
#import "ZSRTest3ViewController.h"
@interface ZSRTest2ViewController ()

@end

@implementation ZSRTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ZSRTest3ViewController *test3= [[ZSRTest3ViewController alloc] init];
    test3.title = @"test3控制器";
    [self.navigationController pushViewController:test3 animated:YES];
}

@end
