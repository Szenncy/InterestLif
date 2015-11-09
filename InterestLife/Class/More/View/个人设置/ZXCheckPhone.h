//
//  ZXCheckPhone.h
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^checkPhoneBlock)();

@interface ZXCheckPhone : UIView

//设置点击按钮的block
- (void)setCheckPhoneBlock:(checkPhoneBlock)block;

@end
