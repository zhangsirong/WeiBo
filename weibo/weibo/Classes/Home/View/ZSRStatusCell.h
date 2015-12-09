//
//  ZSRStatusCell.h
//  weibo
//
//  Created by hp on 15/12/9.
//  Copyright © 2015年 hp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZSRStatusFrame;
@interface ZSRStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) ZSRStatusFrame *statusFrame;
@end
