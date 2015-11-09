//
//  ZXMainItemParagraphsModel.h
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXMainItemPhotoModel.h"
#import <CoreGraphics/CoreGraphics.h>

@interface ZXMainItemParagraphsModel : NSObject

//内容
@property (copy, nonatomic)NSString *content;

//主题
@property (copy, nonatomic)NSString *title;

//存储图片
@property (strong, nonatomic)ZXMainItemPhotoModel *photo;

//存储图片的高度
@property (assign, nonatomic)CGFloat imageHeight;

//存储内容的高度
@property (assign, nonatomic)CGFloat contentHeight;

//存储标题的高度
@property (assign, nonatomic)CGFloat titleHeight;

@end
