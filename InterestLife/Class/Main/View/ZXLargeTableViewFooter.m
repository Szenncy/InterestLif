//
//  ZXLargeTableViewFooter.m
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXLargeTableViewFooter.h"
#import "ZXFooterBtnView.h"
#import "ZXFooterProgressView.h"

@interface ZXLargeTableViewFooter()
{
    commentBlock _commentBlock;
    shareWeChatBlock _shareWeChatBlock;
}
//主要内容
@property (weak, nonatomic) IBOutlet UIView *contentView;
//详细内容
@property (weak, nonatomic) IBOutlet UIView *detailView;
//按钮视图
@property (weak, nonatomic) ZXFooterBtnView *footerBtnView;
//统计视图
@property (weak, nonatomic)ZXFooterProgressView *footerProgressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightSpace;

@end

@implementation ZXLargeTableViewFooter

#pragma mark - 初始化

- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle]loadNibNamed:@"ZXLargeTableViewFooter" owner:self options:nil] lastObject];
    
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    [self addSubview:self.contentView];
    
    [self layoutIfNeeded];
    
    self.footerBtnView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - self.leftSpace.constant - self.rightSpace.constant, self.detailView.frame.size.height);
    
    [self.footerBtnView awakeFromNib];
}

#pragma mark - getter
//按钮视图懒加载
- (ZXFooterBtnView *)footerBtnView{
    if (!_footerBtnView) {
        ZXFooterBtnView *view = [[ZXFooterBtnView alloc]init];
        
        [self.detailView addSubview:view];
        
        [view setBtnTouchBlock:^(UIButton *btn) {
            //1.从父视图中移除
            [self.footerBtnView removeFromSuperview];
            //2.初始化统计视图
            [self.footerProgressView awakeFromNib];
        }];
        
        _footerBtnView = view;
        
    }
    return _footerBtnView;
}

//统计视图懒加载
- (ZXFooterProgressView *)footerProgressView{
    if (!_footerProgressView) {
        ZXFooterProgressView *view = [[ZXFooterProgressView alloc]initWithFrame:self.detailView.bounds];
        
        [self.detailView addSubview:view];
        
        _footerProgressView = view;
    }
    return _footerProgressView;
}

#pragma mark - setter 

- (void)startInit{
    
    [self.footerBtnView awakeFromNib];
}

//评论的Block
- (void)setCommentBlock:(commentBlock)block{
    _commentBlock = block;
}

//分享微信的Block
- (void)setShareWeChatBlock:(shareWeChatBlock)block{
    _shareWeChatBlock = block;
}

#pragma mark - 按钮事件响应
- (IBAction)leftBtnTouch:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲!功能开在开发中哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];
    
    if (_shareWeChatBlock) {
        _shareWeChatBlock(self.item);
    }
    
}
- (IBAction)rightBtnTouch:(id)sender {
    if (_commentBlock) {
        _commentBlock(self.item);
    }
}

@end
