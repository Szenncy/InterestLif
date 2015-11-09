//
//  ZXHelloMoreTableViewCell.h
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXHelloItemModel.h"
#import "ZXHelloLargeTableViewCell.h"

@protocol ZXHelloMoreTableViewCellDelegate <ZXHelloLargeTableViewCellDelegate>

@end

@interface ZXHelloMoreTableViewCell : UITableViewCell

@property (strong, nonatomic)ZXHelloItemModel *item;

@property (assign, nonatomic)id delegate;

@end
