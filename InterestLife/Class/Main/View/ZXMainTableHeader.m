//
//  ZXMainTableHeader.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXMainTableHeader.h"
#import "UIImageView+WebCache.h"
@interface ZXMainTableHeader()
{
    moreBtnClick _clickBlock;
}
//主要界面
@property (weak, nonatomic) IBOutlet UIView *contentView;
//主要内容
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
//详细内容
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
//图片内容
@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;

@end

@implementation ZXMainTableHeader

#pragma mark - 初始化
-(void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"ZXMainTableHeader" owner:self options:nil] lastObject];
    
    self.contentView.frame = self.bounds;
    
    [self addSubview:self.contentView];
    
}

#pragma mark - setter
- (void)setItem:(ZXMainItemModel *)item{
    _item = item;
    self.mainTitleLabel.text = item.title;
    
    self.detailLabel.text = item.summary;
    
    [self.largeImageView sd_setImageWithURL:[NSURL URLWithString:item.photo.mobile_large_url]];
}

- (void)setMoreButtonBlock:(moreBtnClick)block{
    _clickBlock = block;
}

#pragma mark - 事件响应
- (IBAction)btnTouch:(id)sender {
    _clickBlock();
}

@end
