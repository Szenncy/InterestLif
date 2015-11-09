//
//  ZXFooterBtnView.h
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnTouchBlock)(UIButton *btn);

@interface ZXFooterBtnView : UIView

//设置点击按钮Block
- (void)setBtnTouchBlock:(btnTouchBlock)block;
                                  
@end
