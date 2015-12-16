//
//  UITextView+Extension.m
//  weibo
//
//  Created by hp on 15/12/15.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
- (void)insertAttributeText:(NSAttributedString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的文字（图片和普通文字）
    [attributedText appendAttributedString:self.attributedText];


    // 拼接图片
    NSUInteger loc = self.selectedRange.location;
    [attributedText insertAttributedString:text atIndex:loc];
    // 设置字体
    [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
    self.attributedText = attributedText;
    
    // 移除光标到表情的后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}

@end