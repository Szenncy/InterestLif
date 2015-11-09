//
//  ZXMainTableHeader.h
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXMainItemModel.h"

typedef void(^moreBtnClick)();

@interface ZXMainTableHeader : UIView

//更多内容
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

//存储MainItem模型
@property (strong, nonatomic)ZXMainItemModel *item;

//设置按钮响应的block
- (void)setMoreButtonBlock:(moreBtnClick)block;

@end
