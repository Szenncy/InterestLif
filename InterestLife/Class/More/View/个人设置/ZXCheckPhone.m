//
//  ZXCheckPhone.m
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXCheckPhone.h"
#import "ZXFrame.h"
#import "UIView+Frame.h"
#import "ZXColor.h"

@interface ZXCheckPhone()
{
    checkPhoneBlock _checkPhoneBlock;
}

//存储label
@property (weak, nonatomic)UILabel *label;
//存储button
@property (weak, nonatomic)UIButton *button;

@end

@implementation ZXCheckPhone

#pragma mark - getter 

//懒加载label
- (UILabel *)label{
    if (!_label) {
        UILabel *label = [[UILabel alloc]init];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = [UIFont systemFontOfSize:13];
        
        label.textColor = [UIColor lightGrayColor];
        
        label.text = @"你还没有个人信息,请验证手机后登陆";
        
        [self addSubview:label];
        
        _label = label;
    }
    return _label;
}

//懒加载btn
- (UIButton *)button{
    if (!_button) {
        UIButton *btn = [[UIButton alloc]init];
        
        [btn setTitle:@"手机验证" forState:UIControlStateNormal];
        
        [btn setBackgroundColor:ZXGREEN];
        
        btn.layer.cornerRadius = 5;
        
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        _button = btn;
    }
    return _button;
}

#pragma mark - setter

//设置点击按钮的block
- (void)setCheckPhoneBlock:(checkPhoneBlock)block{
    _checkPhoneBlock = block;
}

#pragma mark - 布局

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(ZXSPACE, 100, [UIScreen mainScreen].bounds.size.width - ZXSPACE * 2, 20);
    
    self.button.frame = CGRectMake(ZXSPACE, self.label.maxY + ZXSPACE * 2, [UIScreen mainScreen].bounds.size.width - ZXSPACE * 2, 40);
}

#pragma mark - 事件响应

- (void)btnTouch:(UIButton *)btn{
    if (_checkPhoneBlock) {
        _checkPhoneBlock();
    }
}

@end
