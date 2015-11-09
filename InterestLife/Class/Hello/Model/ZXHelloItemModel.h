//
//  ZXHelloItem.h
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "ZXHelloItemPhotoModel.h"

@interface ZXHelloItemModel : NSObject

@property (copy, nonatomic)NSString *added_on;

@property (copy, nonatomic)NSString *avatar_thumb_url;

@property (copy, nonatomic)NSString *avatar_url;

@property (copy, nonatomic)NSString *content;

@property (copy, nonatomic)NSString *distance;

@property (copy, nonatomic)NSString *ID;

@property (assign, nonatomic)BOOL is_liked;

@property (copy, nonatomic)NSString *loc_city;

@property (copy, nonatomic)NSString *mobile;

@property (strong, nonatomic)NSNumber *num_of_comments;

@property (strong, nonatomic)NSNumber *num_of_likes;

@property (strong, nonatomic)NSNumber *num_of_photos;

@property (strong, nonatomic)NSNumber *num_of_series;

@property (strong, nonatomic)NSArray *photos;

@property (copy, nonatomic)NSString *series_id;

@property (copy, nonatomic)NSString *series_name;

@property (copy, nonatomic)NSString *time;

@property (copy, nonatomic)NSString *type;

@property (copy, nonatomic)NSString *user_gender;

@property (copy, nonatomic)NSString *user_id;

@property (copy, nonatomic)NSString *user_name;

@property (copy, nonatomic)NSString *web_url;

@property (assign, nonatomic)CGFloat contentHeight;

@property (assign, nonatomic)CGFloat imageHeight;

@property (assign, nonatomic)BOOL selected;

@end
