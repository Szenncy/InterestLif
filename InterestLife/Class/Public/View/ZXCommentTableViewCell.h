//
//  ZXCommentTableViewCell.h
//  InterestLife
//
//  Created by zency on 15/9/24.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXCommentItemModel.h"

@class ZXCommentTableViewCell;
@protocol ZXCommentTableViewCellDelegate <NSObject>

- (void)commentTableViewCell:(ZXCommentTableViewCell *)cell anddidSelectUserInfo:(ZXCommentItemModel *)model;

@end

@interface ZXCommentTableViewCell : UITableViewCell

@property (strong, nonatomic)ZXCommentItemModel *item;

@property (assign, nonatomic)id delegate;

@end
