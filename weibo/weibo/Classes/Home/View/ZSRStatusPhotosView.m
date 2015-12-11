//
//  ZSRStatusPhotosView.m
//  weibo
//
//  Created by hp on 15/12/11.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRStatusPhotosView.h"
#import "ZSRStatusPhotoView.h"

#define ZSRStatusPhotoWH 70
#define ZSRStatusPhotoMargin 10
#define ZSRStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation ZSRStatusPhotosView

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    int photosCount = photos.count;
    
    
    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
    while (self.subviews.count < photosCount) {
        ZSRStatusPhotoView *photoView = [[ZSRStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        ZSRStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) { // 显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    int photosCount = self.photos.count;
    int maxCol = ZSRStatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount; i++) {
        ZSRStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (ZSRStatusPhotoWH + ZSRStatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (ZSRStatusPhotoWH + ZSRStatusPhotoMargin);
        photoView.width = ZSRStatusPhotoWH;
        photoView.height = ZSRStatusPhotoWH;
    }
}

+ (CGSize)sizeWithCount:(int)count
{
    // 最大列数（一行最多有多少列）
    int maxCols = ZSRStatusPhotoMaxCol(count);
    
    ///列数
    int cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * ZSRStatusPhotoWH + (cols - 1) * ZSRStatusPhotoMargin;
    
    // 行数
    int rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * ZSRStatusPhotoWH + (rows - 1) * ZSRStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}


@end
