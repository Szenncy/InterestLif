//
//  ZXMainTableViewCell.h
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXMainItemModel.h"
@interface ZXMainTableViewCell : UITableViewCell

//数据源
@property (strong, nonatomic)ZXMainItemModel *item;

@end
