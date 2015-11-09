//
//  ZXMainItemPhotoModel.h
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXMainItemPhotoModel : NSObject

//手机的大图片
@property (copy, nonatomic)NSString *mobile_large_url;

//手机图片
@property (copy, nonatomic)NSString *mobile_url;

//原始图片
@property (copy, nonatomic)NSString *original_url;

//风格图片
@property (copy, nonatomic)NSString *thumb_url;

@end
