//
//  ZXTopCommentView.m
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXTopCommentView.h"

@interface ZXTopCommentView()
{
    //当前被选中的按钮
    UIButton *_currentBtn;
    //block
    didSelectBtnBlock _block;
}
//内容视图
@property (weak, nonatomic) IBOutlet UIView *contentView;

//左侧的按钮
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

//右侧的按钮
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation ZXTopCommentView

#pragma mark - 初始化

- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"ZXTopCommentView" owner:self options:nil] lastObject];
    
    self.contentView.frame = self.bounds;
    
    [self addSubview:self.contentView];
    
    _currentBtn = self.leftBtn;
}

#pragma mark - setter

- (void)setLeftTitle:(NSString *)leftTitle{
    _leftTitle = leftTitle;
    
    [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
}

- (void)setRightTitle:(NSString *)rightTitle{
    _rightTitle = rightTitle;
    
    [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
}

//设置点击按钮的Block
- (void)setDidSelectedBtnBlock:(didSelectBtnBlock)block{
    _block = block;
}

#pragma mark - 事件响应
//左边按钮的点击
- (IBAction)leftBtnClick:(UIButton *)sender {
    
    [_currentBtn setBackgroundImage:[UIImage imageNamed:@"bg_segmented"] forState:UIControlStateNormal];
    
    [sender setBackgroundImage:[UIImage imageNamed:@"bg_segmented_pressed_left"] forState:UIControlStateNormal];
    
    _currentBtn = sender;
    
    if (_block) {
        _block(sender);
    }
}

//右边按钮的点击
- (IBAction)rightBtnClick:(UIButton *)sender {
    
    [_currentBtn setBackgroundImage:[UIImage imageNamed:@"bg_segmented"] forState:UIControlStateNormal];
    
    [sender setBackgroundImage:[UIImage imageNamed:@"bg_segmented_pressed_right"] forState:UIControlStateNormal];
    
     _currentBtn = sender;
    
    if (_block) {
        _block(sender);
    }
}


@end
