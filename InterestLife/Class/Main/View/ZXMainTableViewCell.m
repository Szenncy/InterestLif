//
//  ZXMainTableViewCell.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXMainTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Date.h"
#import "ZXColor.h"

@interface ZXMainTableViewCell()

//头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//标题label
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;

//详细label
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

//标签tab
@property (weak, nonatomic) IBOutlet UIButton *tabButton;

//更新标签
@property (weak, nonatomic) IBOutlet UIImageView *updateImageView;

@end

@implementation ZXMainTableViewCell

#pragma mark - 初始化
- (void)awakeFromNib {
    self.tabButton.layer.cornerRadius = 5;
}

#pragma mark - setter

- (void)setItem:(ZXMainItemModel *)item{
    _item = item;
    self.mainTitleLabel.text = item.title;
    
    self.detailLabel.text = item.summary;
    
    //根据文字修改颜色
    [self changeColorForTagsWithString:item.tags];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.photo.mobile_url]];
    
    //确认是否是最新的
    if ([self checkUpdateWithOrder:item.order]) {
        self.updateImageView.image = [UIImage imageNamed:@"new-label"];
        self.mainTitleLabel.textColor = ZXPINK;
    }
}

#pragma mark - 内部逻辑运算

//1.判断是否是最新
- (BOOL)checkUpdateWithOrder:(NSNumber *)order{
    
    NSString *str = [[NSString stringWithFormat:@"%@",order] substringToIndex:8];
    
    NSString *nowTime = [NSString stringTimeIntervalSince1970];
    
    NSString *now = [NSString stringWithTimeFormat:@"yyyyMMdd" andTimeInterval:[nowTime intValue]];
    
    if ([str isEqualToString:now]) {
        return YES;
    }
    
    return NO;
}

//2.改变标签的颜色
- (void)changeColorForTagsWithString:(NSString *)str{
    
    [self.tabButton setTitle:str forState:UIControlStateNormal];
    if ([str isEqualToString:@"八卦"]) {
        self.tabButton.backgroundColor = ZXPINK;
    }else if([str isEqualToString:@"漫画"]){
        self.tabButton.backgroundColor = ZXGREEN;
    }else if([str isEqualToString:@"感悟"]){
        self.tabButton.backgroundColor = [UIColor purpleColor];
    }else if([str isEqualToString:@"笑话"]){
        self.tabButton.backgroundColor = [UIColor orangeColor];
    }else if([str isEqualToString:@"故事"]){
        self.tabButton.backgroundColor = [UIColor redColor];
    }else if ([str isEqualToString:@"好囧"]){
        self.tabButton.backgroundColor = [UIColor yellowColor];
    }
}

@end
