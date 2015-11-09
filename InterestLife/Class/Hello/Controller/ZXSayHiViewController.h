//
//  ZXSayHiViewController.h
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXHelloItemModel.h"
#import "ZXCommentItemModel.h"

@interface ZXSayHiViewController : UIViewController

//获取数据源
@property (strong, nonatomic)ZXHelloItemModel *item;

//数据源
@property (strong, nonatomic)ZXCommentItemModel *commentItem;

@property (strong, nonatomic)NSString *style;

@end
