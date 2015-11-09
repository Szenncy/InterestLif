//
//  ZXHelloLargeTableViewCell.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXHelloLargeTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ZXHelloLargeTableViewCell()

//背景图
@property (weak, nonatomic) IBOutlet UIView *backView;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//名字Label
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//性别图案
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
//省份
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
//城市
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
//图片的数组
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *contentImageViews;
//内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//笑脸的按钮
@property (weak, nonatomic) IBOutlet UIButton *smileButton;
//故事的按钮
@property (weak, nonatomic) IBOutlet UIButton *storyButton;
//评论的按钮
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
//笑脸的Label
@property (weak, nonatomic) IBOutlet UILabel *smileLabel;
//image的Height
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@end

@implementation ZXHelloLargeTableViewCell

#pragma mark - 初始化
- (void)awakeFromNib {
    // Initialization code
    
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.borderWidth = 0.5;
    self.backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

#pragma mark - setter
- (void)setItem:(ZXHelloItemModel *)item{
    _item = item;
    
    //设置头像
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.avatar_url]];
    
    //设置头像点击手势
    self.iconImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconTouch:)];
    
    [self.iconImageView addGestureRecognizer:tap];
    
    //设置名字
    self.nameLabel.text = item.user_name;
    
    
    //设置性别
    self.sexImageView.image = [item.user_gender boolValue]?[UIImage imageNamed:@"icon_male"]:[UIImage imageNamed:@"icon_female"];
    
    //设置省份
    NSArray *objs = [item.loc_city componentsSeparatedByString:@" "];
    
    self.provinceLabel.text = objs[0];
    
    //设置城市
    self.cityLabel.text = objs[1];
    
    for (int i = 0; i < self.contentImageViews.count; i ++ )
    {
        [self.contentImageViews[i] sd_setImageWithURL:nil placeholderImage:nil];
        
        UIImageView *image = self.contentImageViews[i];
        
        image.userInteractionEnabled = NO;
    }
    
    if (item.imageHeight == 0){
        self.imageHeight.constant = 111;
    }else{
        self.imageHeight.constant = 0;
    }
    
    
    //设置图片
    for (int i = 0; i < [item.num_of_photos integerValue]; i ++ )
    {
        ZXHelloItemPhotoModel *photo = item.photos[i];
        
        [self.contentImageViews[i] sd_setImageWithURL:[NSURL URLWithString:photo.mobile_url ] placeholderImage:nil];
        
        [self.contentImageViews[i] setTag:618 + i];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch:)];
        
        [self.contentImageViews[i] addGestureRecognizer:tapGesture];
        
        UIImageView *image = self.contentImageViews[i];
        
        image.userInteractionEnabled = YES;
        
    }
    //设置内容
    
    if (item.content == nil) {
        self.contentLabel.text = @"";
    }else{
        self.contentLabel.text = item.content;
    }
    
    //设置时间
    self.timeLabel.text = item.time;
    
    self.smileButton.selected = item.selected;
    
    if (item.selected) {
        [self.smileButton setImage:[UIImage imageNamed:@"btn_liked"] forState:UIControlStateNormal];
    }else{
        [self.smileButton setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
    }
    //设置smileLabel
    
    if ([item.num_of_likes integerValue] == 0) {
        self.smileLabel.text = @"";
    }else{
        self.smileLabel.text = [item.num_of_likes stringValue];
    }
    
    
    
}

#pragma mark - 按钮响应事件

- (IBAction)smileBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.item.selected = sender.selected;
    
    if (sender.selected) {
        
        int page = [self.item.num_of_likes intValue];
        
        page ++ ;
        
        self.item.num_of_likes = @(page);
        
        self.smileLabel.text = [self.item.num_of_likes stringValue];
        [sender setImage:[UIImage imageNamed:@"btn_liked"] forState:UIControlStateNormal];
    }else{
        
        int page = [self.item.num_of_likes intValue];
        
        page -- ;
        
        if (page < 0) {
            page = 0;
        }
        
        self.item.num_of_likes = @(page);
        
        if ([self.item.num_of_likes intValue] == 0) {
            self.smileLabel.text = @"";
        }else{
            self.smileLabel.text = [self.item.num_of_likes stringValue];
        }
        
        [sender setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
    }
    
    if ([self.delegate respondsToSelector:@selector(helloLargeTableViewCell:anddidSelectedSmile:andModel:)]) {
        [self.delegate helloLargeTableViewCell:self anddidSelectedSmile:sender andModel:self.item];
    }
}
- (IBAction)storyBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(helloLargeTableViewCell:anddidSelectedStory:andModel:)]) {
        [self.delegate helloLargeTableViewCell:self anddidSelectedStory:sender andModel:self.item];
    }
}
- (IBAction)commentBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(helloLargeTableViewCell:anddidSelectedComment:andModel:)]) {
        [self.delegate helloLargeTableViewCell:self anddidSelectedComment:sender andModel:self.item];
    }
}

- (void)tapTouch:(UITapGestureRecognizer *)gesture{
    if ([self.delegate respondsToSelector:@selector(helloLargeTableViewCell:anddidSelectedImage:andModel:andIndex:)]) {
        [self.delegate helloLargeTableViewCell:self anddidSelectedImage:(UIImageView *)gesture.view andModel:self.item andIndex:gesture.view.tag - 618];
    }
}

- (void)tapIconTouch:(UITapGestureRecognizer *)gesture{
    
    if ([self.delegate respondsToSelector:@selector(helloLargeTableViewCell:anddidSelectedIconImage:andModel:)]) {
        [self.delegate helloLargeTableViewCell:self anddidSelectedIconImage:(UIImageView *)gesture.view andModel:self.item];
    }
}

@end
