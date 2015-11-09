//
//  ZXLargeTableViewFooter.h
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXMainItemModel.h"

typedef void(^shareWeChatBlock)(ZXMainItemModel *item);

typedef void(^commentBlock)(ZXMainItemModel *item);

@interface ZXLargeTableViewFooter : UIView

@property (strong, nonatomic)ZXMainItemModel *item;

@property (weak, nonatomic)UIViewController *viewController;


//评论的Block
- (void)setCommentBlock:(commentBlock)block;

//分享微信的Block
- (void)setShareWeChatBlock:(shareWeChatBlock)block;

@end
