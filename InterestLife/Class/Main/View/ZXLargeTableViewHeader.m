//
//  ZXLargeTableViewHeader.m
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXLargeTableViewHeader.h"

@interface ZXLargeTableViewHeader()
//主要内容
@property (weak, nonatomic) IBOutlet UIView *contentView;

//大标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

//小标题
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


@end

@implementation ZXLargeTableViewHeader

#pragma mark - 初始化

- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle]loadNibNamed:@"ZXLargeTableViewHeader" owner:self options:nil] lastObject];
    
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    [self addSubview:self.contentView];
}

#pragma mark - setter

- (void)setItem:(ZXMainItemModel *)item{
    _item = item;
    
    self.titleLabel.text = item.title;
    
    self.detailLabel.text = [NSString stringWithFormat:@"%@ | %@",item.tags,item.author];
}

@end
