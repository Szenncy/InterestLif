//
//  ZXHelloItemPhotoModel.h
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXHelloItemPhotoModel : NSObject

@property (copy, nonatomic)NSString *mobile_large_url;

@property (copy, nonatomic)NSString *mobile_url;

@property (copy, nonatomic)NSString *thumb_url;

@property (strong, nonatomic)NSNumber *mobile_height;

@property (strong, nonatomic)NSNumber *mobile_large_height;

@property (strong, nonatomic)NSNumber *thumb_height;

@end
