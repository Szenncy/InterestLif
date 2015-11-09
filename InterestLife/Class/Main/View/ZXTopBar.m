//
//  ZXTopBar.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXTopBar.h"
#import "NSString+Date.h"

@interface ZXTopBar()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation ZXTopBar

#pragma mark - 初始化
//初始化xib
- (void)awakeFromNib{
    
    self.contentView = [[[NSBundle mainBundle]loadNibNamed:@"ZXTopBar" owner:self options:nil] lastObject];
    
    self.contentView.frame = self.bounds;
    
    [self addSubview:self.contentView];
}

#pragma mark - setter

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    
    NSString *now = [NSString stringTimeIntervalSince1970];
    
    [self.nowTime setTitle:[NSString stringWithTimeFormat:@"HH:mm" andTimeInterval:[now integerValue]] forState:UIControlStateNormal];
}

@end
