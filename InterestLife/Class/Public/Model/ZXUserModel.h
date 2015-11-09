//
//  ZXUserModel.h
//  InterestLife
//
//  Created by zency on 15/9/24.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXMainItemPhotoModel.h"

@interface ZXUserModel : NSObject

@property (copy, nonatomic)NSString *added_on;

@property (copy, nonatomic)NSNumber *ID;

@property (copy, nonatomic)NSString *last_login_time;

@property (copy, nonatomic)NSString *mobile;

@property (strong, nonatomic)ZXMainItemPhotoModel *avatar;

@end
