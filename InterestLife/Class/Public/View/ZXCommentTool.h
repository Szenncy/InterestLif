//
//  ZXCommentTool.h
//  InterestLife
//
//  Created by zency on 15/9/24.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXCommentTool : UIView

//内容框
//@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextField;

@property (assign, nonatomic)BOOL show;

- (void)showKeyboard;

@end
