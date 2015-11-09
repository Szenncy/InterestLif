//
//  ZXCommentTool.m
//  InterestLife
//
//  Created by zency on 15/9/24.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXCommentTool.h"

@interface ZXCommentTool()<UITextFieldDelegate>
//说话按钮
@property (weak, nonatomic) IBOutlet UIButton *speakButton;

//发送按钮
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation ZXCommentTool

#pragma mark - 初始化
- (void)awakeFromNib{
    self.sendButton.layer.cornerRadius = 5;
    self.contentTextField.layer.borderWidth = 0.5;
    self.contentTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.contentTextField.layer.cornerRadius = 5;
    self.contentTextField.layer.masksToBounds = YES;
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲!有些功能开在开发中哦,敬请期待" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];
}

#pragma mark - 键盘股哪里
- (void)showKeyboard{
    _show = !_show;
    
    if (_show) {
        [self.contentTextField becomeFirstResponder];
    }else{
        [self.contentTextField resignFirstResponder];
    }
}


@end
