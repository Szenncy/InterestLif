//
//  ZXFooterBtnView.m
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXFooterBtnView.h"

@interface ZXFooterBtnView()
{
    btnTouchBlock _clickBtn;
}
//主视图
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ZXFooterBtnView

#pragma mark - 初始化

- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"ZXFooterBtnView" owner:self options:nil] lastObject];
    
    self.contentView.frame = self.bounds;
    
    
    [self addSubview:self.contentView];
}

#pragma mark - setter
//设置点击按钮Block
- (void)setBtnTouchBlock:(btnTouchBlock)block{
    _clickBtn = block;
}

#pragma mark - 按钮响应事件

- (IBAction)btnTouch:(id)sender {
    
    if (_clickBtn) {
        _clickBtn(sender);
    }
}


@end
