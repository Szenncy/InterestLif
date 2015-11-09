//
//  ZXHelloLargeTableViewCell.h
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXHelloItemModel.h"

@class ZXHelloLargeTableViewCell;
@protocol ZXHelloLargeTableViewCellDelegate <NSObject>

//点击笑脸
- (void)helloLargeTableViewCell:(id)cell anddidSelectedSmile:(UIButton *)btn andModel:(ZXHelloItemModel *)model;

//点击故事
- (void)helloLargeTableViewCell:(id)cell anddidSelectedStory:(UIButton *)btn andModel:(ZXHelloItemModel *)model;

//点击评论
- (void)helloLargeTableViewCell:(id)cell anddidSelectedComment:(UIButton *)btn andModel:(ZXHelloItemModel *)model;

//点击图片
- (void)helloLargeTableViewCell:(id)cell anddidSelectedImage:(UIImageView *)image andModel:(ZXHelloItemModel *)model andIndex:(NSInteger)index;

//点击头像
- (void)helloLargeTableViewCell:(id)cell anddidSelectedIconImage:(UIImageView *)image andModel:(ZXHelloItemModel *)model;

@end

@interface ZXHelloLargeTableViewCell : UITableViewCell

//数据源
@property (strong, nonatomic)ZXHelloItemModel *item;
//代理对象
@property (assign, nonatomic)id delegate;

@end
