//
//  ZXInterestTableViewCell.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXInterestTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ZXInterestTableViewCell()
//文章的内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//文章的图片
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
//照片的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

//来自哪里
@property (weak, nonatomic) IBOutlet UILabel *comeFromLabel;
//收藏的按钮
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
//分享到微信
@property (weak, nonatomic) IBOutlet UIButton *shareToWeChatButton;
//评论
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation ZXInterestTableViewCell

#pragma mark - 初始化
- (void)awakeFromNib {
    
    //2.设置图像
    self.contentImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch:)];
    
    [self.contentImageView addGestureRecognizer:tapGesture];
}

#pragma mark - setter
- (void)setItem:(ZXInterestItemModel *)item{
    _item = item;
    
    self.contentLabel.text = item.content;
    
    self.comeFromLabel.text = [NSString stringWithFormat:@"来自%@",item.source];
    
    if (item.imageHeight == 80) {
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:item.pic]];
    }
    
    self.imageHeight.constant = item.imageHeight;
    
    [self.commentButton setTitle:[NSString stringWithFormat:@"评论( %@ )",item.comments] forState:UIControlStateNormal];
    
    self.collectButton.selected = item.selected;
    
    if (self.collectButton.selected) {
        [self.collectButton setImage:[UIImage imageNamed:@"icon_nav_bookmarked"] forState:UIControlStateNormal];
    }else{
        [self.collectButton setImage:[UIImage imageNamed:@"icon_nav_bookmark"] forState:UIControlStateNormal];
    }
}

#pragma mark - 事件响应

//点击收藏按钮
- (IBAction)collectionBtnClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [btn setImage:[UIImage imageNamed:@"icon_nav_bookmarked"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"icon_nav_bookmark"] forState:UIControlStateNormal];
    }
    
    
    if ([self.delegate respondsToSelector:@selector(interestTableViewCell:anddidSelectedCollection:andModel:)])
    {
        [self.delegate interestTableViewCell:self anddidSelectedCollection:sender andModel:self.item];
    }
    
}

//点击分享按钮
- (IBAction)shareBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(interestTableViewCell:anddidSelectedShare:andModel:)])
    {
        [self.delegate interestTableViewCell:self anddidSelectedShare:sender andModel:self.item];
    }
}

//点击评论按钮
- (IBAction)commentBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(interestTableViewCell:anddidSelectedComment:andModel:)])
    {
        [self.delegate interestTableViewCell:self anddidSelectedComment:sender andModel:self.item];
    }
}

- (void)tapTouch:(UITapGestureRecognizer *)gesture{
    if ([self.delegate respondsToSelector:@selector(interestTableViewCell:anddidSelectedImage:andModel:)])
    {
        [self.delegate interestTableViewCell:self anddidSelectedImage:self.contentImageView andModel:self.item];
    }
}




@end
