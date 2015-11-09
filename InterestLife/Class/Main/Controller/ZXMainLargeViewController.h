//
//  ZXMainLargeViewController.h
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXMainModel.h"

@interface ZXMainLargeViewController : UIViewController

@property (strong, nonatomic)ZXMainItemModel *item;

@property (assign, nonatomic)NSInteger page;

- (NSMutableArray *)items;

- (void)setItems:(NSMutableArray *)items;

@end
