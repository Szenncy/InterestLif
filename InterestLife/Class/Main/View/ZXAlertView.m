//
//  ZXAlertView.m
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXAlertView.h"

@interface ZXAlertView()
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

@end

@implementation ZXAlertView

- (void)setTitle:(NSString *)title{
    _title = title;
    
    [self.titleBtn setTitle:title forState:UIControlStateNormal];
}

@end
