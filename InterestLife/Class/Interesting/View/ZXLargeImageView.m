//
//  ZXLargeImageView.m
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXLargeImageView.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface ZXLargeImageView()

//scrollView
@property (weak, nonatomic)UIScrollView *srollView;
//imageView
@property (weak, nonatomic)UIImageView *imageView;
//网络请求
@property (strong, nonatomic)AFHTTPRequestOperation *operation;
//进度条
@property (weak, nonatomic)MBProgressHUD *progressView;


@end

@implementation ZXLargeImageView

#pragma mark - 生命周期

- (void)dealloc{
    
    [[SDWebImageManager sharedManager] cancelAll];
    
}

#pragma mark - getter

//懒加载scrollView
- (UIScrollView *)srollView{
    if (!_srollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        [self addSubview:scrollView];
        
        _srollView = scrollView;
    }
    return _srollView;
}

//懒加载imageView
- (UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.srollView addSubview:imageView];
        
        _imageView = imageView;
    }
    return _imageView;
}

//懒加载进度栏
- (MBProgressHUD *)progressView{
    if (!_progressView) {
        MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self animated:YES];
        
        progress.mode = MBProgressHUDModeDeterminate;
        
        //[self addSubview:progress];
        
        _progressView = progress;
        
    }
    return _progressView;
}

#pragma mark - setter

//重写item的set方法
- (void)setItem:(ZXInterestItemModel *)item{
    _item = item;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.pic] placeholderImage:nil options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        [self countProgressWithTotalBytesRead:receivedSize andTotalBytesExpectedToRead:expectedSize];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [self setViewFrame:image];
        
    }];
    
    //[self netWorkingWithUrlString:item.pic];
}

- (void)setImageUrlString:(NSString *)imageUrlString{
    _imageUrlString = imageUrlString;
    
    self.progressView.mode = 0;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:nil options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        [self countProgressWithTotalBytesRead:receivedSize andTotalBytesExpectedToRead:expectedSize];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [self setViewFrame:image];
        
    }];

}


#pragma mark - 网络

//被我遗弃了 换成sd有缓存的..这里我懒的删
- (void)netWorkingWithUrlString:(NSString *)urlString{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"image/jpeg"];
    
    self.operation = [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        UIImage *image = [UIImage imageWithData:operation.responseData];
        
        [self setViewFrame:image];
        
        self.operation = nil;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    __weak ZXLargeImageView *view = self;
    
    [self.operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        [view countProgressWithTotalBytesRead:totalBytesRead andTotalBytesExpectedToRead:totalBytesExpectedToRead];
    }];
    
}

#pragma mark - 内部逻辑算法

- (CGFloat)heightWithOriginSize:(CGSize)size{
    
    /*
     
     oh      ch
     ---     ---
     ow      cw
     
     ch = (oh * cw) / ow
     */
    
    return (float)(size.height * [UIScreen mainScreen].bounds.size.width)/size.width;
    
}

//设置progress
- (void)countProgressWithTotalBytesRead:(long long)totalBytesRead andTotalBytesExpectedToRead:(long long)totalBytesExpectedToRead{
    
    self.progressView.progress = (float)totalBytesRead/totalBytesExpectedToRead;
    
    if ((float)totalBytesRead/totalBytesExpectedToRead == 1.0)
    {
        [self.progressView hide:YES];
    }
}

//设置Frame
- (void)setViewFrame:(UIImage *)image{
    CGFloat height = [self heightWithOriginSize:image.size];
    
    if (height > [UIScreen mainScreen].bounds.size.height) {
        self.srollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, height);
        
        self.imageView.image = image;
        
        self.imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    }else{
        self.srollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        self.imageView.image = image;
        
        self.imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    
}


@end
