//
//  ZXInterestTableViewCell.h
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXInterestItemModel.h"

@class ZXInterestTableViewCell,ZXInterestItemModel;
@protocol ZXInterestTableViewCellDelegate <NSObject>

//点击收藏的按钮
- (void)interestTableViewCell:(ZXInterestTableViewCell *)cell anddidSelectedCollection:(UIButton *)btn andModel:(ZXInterestItemModel *)model;

//点击分享的按钮
- (void)interestTableViewCell:(ZXInterestTableViewCell *)cell anddidSelectedShare:(UIButton *)btn andModel:(ZXInterestItemModel *)model;

//点击评论的按钮
- (void)interestTableViewCell:(ZXInterestTableViewCell *)cell anddidSelectedComment:(UIButton *)btn andModel:(ZXInterestItemModel *)model;

//点击图像
- (void)interestTableViewCell:(ZXInterestTableViewCell *)cell anddidSelectedImage:(UIImageView *)imageView andModel:(ZXInterestItemModel *)model;

@end

@interface ZXInterestTableViewCell : UITableViewCell

//数据源
@property (strong, nonatomic)ZXInterestItemModel *item;

//代理对象
@property (assign, nonatomic)id delegate;


@end
