//
//  ZXLargeDetailTableViewCell.m
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXLargeDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ZXFrame.h"

@interface ZXLargeDetailTableViewCell()

//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//大图片
@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;

@end

@implementation ZXLargeDetailTableViewCell

#pragma mark - 初始化

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - setter

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(ZXMainItemParagraphsModel *)item{
    _item = item;
    
    self.contentLabel.text = item.content;
    
    [self setLabelLine];
    
    self.titleLabel.text = item.title;
    
    [self.largeImageView sd_setImageWithURL:[NSURL URLWithString:item.photo.mobile_url]];
    
}

#pragma mark - 内部逻辑算法

//设置Label的间距
- (void)setLabelLine{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.contentLabel.text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    [paragraphStyle setLineSpacing:10];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.contentLabel.text.length)];
    
    self.contentLabel.attributedText = attributedString;
    
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - ZXSPACE * 4, MAXFLOAT);
    
    CGSize labelSize = [self.contentLabel sizeThatFits:size];
    
    self.item.contentHeight = labelSize.height;
}

@end
