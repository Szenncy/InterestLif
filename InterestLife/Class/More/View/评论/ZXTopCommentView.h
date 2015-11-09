//
//  ZXTopCommentView.h
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didSelectBtnBlock)(UIButton *btn);

@interface ZXTopCommentView : UIView

//返回按钮
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

//左边的文字
@property (copy, nonatomic)NSString *leftTitle;

//右侧的文字
@property (copy, nonatomic)NSString *rightTitle;

//设置点击按钮的Block
- (void)setDidSelectedBtnBlock:(didSelectBtnBlock)block;

@end
