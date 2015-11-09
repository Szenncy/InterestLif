//
//  ZXToolBar.m
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXToolBar.h"

@interface ZXToolBar()
{
    btnTouchBlock _clickBlock;
}

@end

@implementation ZXToolBar

#pragma mark - setter
- (void)setItem:(NSArray *)item{
    _item = item;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/item.count;
    CGFloat height = 49;
    
    for (int i = 0; i < item.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i * width, 0, width, height)];
        
        [btn setImage:[UIImage imageNamed:item[i]] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = 618 + i;
        
        [self addSubview:btn];
    }
}

- (void)setBtnTouchBlock:(btnTouchBlock)block{
    _clickBlock = block;
}

- (void)setMyselected:(BOOL)myselected{
    
    _myselected = myselected;
    
    UIButton *btn = (UIButton *)[self viewWithTag:618];
    
    if (myselected) {
        [btn setImage:[UIImage imageNamed:@"icon_nav_bookmarked"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"icon_nav_bookmark"] forState:UIControlStateNormal];
    }
}

#pragma mark - 事件响应
- (void)btnTouch:(UIButton *)btn{
    
    if ((btn.tag - 618) == ZXToolBarStateCollection) {
        
        btn.selected = !self.myselected;
        
        if (btn.selected) {
            [btn setImage:[UIImage imageNamed:@"icon_nav_bookmarked"] forState:UIControlStateNormal];
        }else{
            [btn setImage:[UIImage imageNamed:@"icon_nav_bookmark"] forState:UIControlStateNormal];
        }
    }
    if (_clickBlock) {
        _clickBlock(btn);
    }
    
}


@end
