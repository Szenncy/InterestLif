//
//  ZXTopBar.h
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXTopBar : UIView

//右边的按钮
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
//左侧的按钮
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
//时间的按钮
@property (weak, nonatomic) IBOutlet UIButton *nowTime;
//标题
@property (copy, nonatomic)NSString *title;

@end
