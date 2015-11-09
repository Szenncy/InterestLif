//
//  ZXFooterProgressVIew.m
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXFooterProgressView.h"

@interface ZXFooterProgressView()

//主视图
@property (weak, nonatomic) IBOutlet UIView *contentView;
//有意思
@property (weak, nonatomic) IBOutlet UIProgressView *interestProgressVIew;
//没意思
@property (weak, nonatomic) IBOutlet UIProgressView *uninterestProgressView;

@end

@implementation ZXFooterProgressView

#pragma mark - 初始化
- (void)awakeFromNib{
    self.contentView = [[[NSBundle mainBundle] loadNibNamed:@"ZXFooterProgressView" owner:self options:nil] lastObject];
    
    self.contentView.frame = self.bounds;
    
    
    [self addSubview:self.contentView];
}



@end
