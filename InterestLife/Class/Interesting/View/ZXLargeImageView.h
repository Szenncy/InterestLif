//
//  ZXLargeImageView.h
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXInterestItemModel.h"

@interface ZXLargeImageView : UIView

//数据源
@property (strong, nonatomic)ZXInterestItemModel *item;

@property (copy, nonatomic)NSString *imageUrlString;

@end
