//
//  ZXCommentItemModel.h
//  InterestLife
//
//  Created by zency on 15/9/24.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "ZXUserModel.h"

@interface ZXCommentItemModel : NSObject

@property (copy, nonatomic)NSString *added_on;

@property (copy, nonatomic)NSNumber *article_id;

@property (copy, nonatomic)NSString *content;

@property (copy, nonatomic)NSNumber *ID;

@property (copy, nonatomic)NSString *nick_name;

@property (strong, nonatomic)ZXCommentItemModel *quote;

@property (copy, nonatomic)NSNumber *stream_post_id;

@property (copy, nonatomic)NSString *time;

@property (copy, nonatomic)ZXUserModel *user;

@property (assign, nonatomic)CGFloat quoteHeight;

@property (assign, nonatomic)CGFloat contentHeight;

@end
