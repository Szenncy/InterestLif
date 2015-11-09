//
//  ZXCommentTableViewCell.m
//  InterestLife
//
//  Created by zency on 15/9/24.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXCommentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Addition.h"

@interface ZXCommentTableViewCell()

//头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//头像的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;
//从哪
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
//到哪
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
//回复
@property (weak, nonatomic) IBOutlet UILabel *replayLabel;
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//追加
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;
//内容 
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ZXCommentTableViewCell

#pragma mark - 初始化

- (void)awakeFromNib {
    // Initialization code
    
    UITapGestureRecognizer *tapToGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToTouch:)];
    
    [self.toLabel addGestureRecognizer:tapToGesture];
    
    UITapGestureRecognizer *tapFromGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFromTouch:)];
    
    [self.fromLabel addGestureRecognizer:tapFromGesture];
    
}

#pragma mark - setter

- (void)setItem:(ZXCommentItemModel *)item{
    _item = item;
    //1.时间
    self.timeLabel.text = item.time;
    
    //2.头像的判断
    if (!item.user.avatar) {
        self.iconWidth.constant = 0;
        self.fromLabel.textColor = [UIColor lightGrayColor];
        self.fromLabel.userInteractionEnabled= NO;
    }else{
        self.iconWidth.constant = 40;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.user.avatar.mobile_url]];
        self.fromLabel.userInteractionEnabled = YES;
        self.fromLabel.textColor = [UIColor blueColor];
    }
    
    //3.从哪的名字
    self.fromLabel.text = item.nick_name;
    
    //4.判断去哪的名字
    if (item.quote.nick_name == nil) {
        self.replayLabel.hidden = YES;
        self.toLabel.text = item.quote.nick_name;
    }else{
        self.replayLabel.hidden = NO;
        self.toLabel.text = item.quote.nick_name;
    }
    
    //5.判断是否蓝色
    if (!item.quote.user.avatar) {
        self.toLabel.textColor = [UIColor lightGrayColor];
        self.toLabel.userInteractionEnabled = NO;
    }else{
        self.toLabel.textColor = [UIColor blueColor];
        self.toLabel.userInteractionEnabled = YES;
    }
    
    //6.quote内容
    self.quoteLabel.text = item.quote.content;
    
    item.quoteHeight = [item.quote.content sizeWithFont:[UIFont systemFontOfSize:15] andMaxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, MAXFLOAT)].height;
    
    //7.content内容
    self.contentLabel.text = item.content;
    
    item.contentHeight = [item.content sizeWithFont:[UIFont systemFontOfSize:13] andMaxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 32, MAXFLOAT)].height;
}

#pragma mark - 事件响应

- (void)tapToTouch:(UITapGestureRecognizer *)gesture{
    
    [self.delegate commentTableViewCell:self anddidSelectUserInfo:self.item.quote];

}

- (void)tapFromTouch:(UITapGestureRecognizer *)gesture{
    
    [self.delegate commentTableViewCell:self anddidSelectUserInfo:self.item];
}

@end