//
//  ZXToolBar.h
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZXToolBarStateCollection,
    ZXToolBarStateShare,
    ZXToolBarStateInFont,
    ZXToolBarStateNext
} ZXToolBarState;

typedef void(^btnTouchBlock)(UIButton *btn);

@interface ZXToolBar : UIView

//存储按钮图像的名称
@property (strong, nonatomic)NSArray *item;

//被选中
@property (assign, nonatomic)BOOL myselected;

//设置点击按钮的Block
- (void)setBtnTouchBlock:(btnTouchBlock)block;

@end
