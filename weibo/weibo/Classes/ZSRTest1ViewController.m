//
//  ZSRTest1ViewController.m
//  weibo
//
//  Created by hp on 15/11/28.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRTest1ViewController.h"
#import "ZSRTest2ViewController.h"
@interface ZSRTest1ViewController ()

@end

@implementation ZSRTest1ViewController

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
    ZSRTest2ViewController *test2 = [[ZSRTest2ViewController alloc] init];
    test2.title = @"test2控制器";
    [self.navigationController pushViewController:test2 animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
