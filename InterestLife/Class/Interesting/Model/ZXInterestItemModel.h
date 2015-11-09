//
//  ZXInterestItemModel.h
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ZXInterestItemModel : NSObject

@property (copy, nonatomic)NSString *added_on;

@property (copy, nonatomic)NSString *author;

@property (copy, nonatomic)NSString *comments;

@property (copy, nonatomic)NSString *content;

@property (copy, nonatomic)NSNumber *ID;

@property (copy, nonatomic)NSString *link;

@property (copy, nonatomic)NSString *pic;

@property (copy, nonatomic)NSString *post_type;

@property (copy, nonatomic)NSString *source;

@property (copy, nonatomic)NSString *thumb;

@property (copy, nonatomic)NSString *time;

@property (copy, nonatomic)NSString *web_url;

@property (assign, nonatomic)CGFloat contentHeight;

@property (assign, nonatomic)CGFloat imageHeight;

@property (assign, nonatomic)BOOL selected;

@end
