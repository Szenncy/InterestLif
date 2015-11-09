//
//  ZXUserModel.m
//  InterestLife
//
//  Created by zency on 15/9/24.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXUserModel.h"

@implementation ZXUserModel

#pragma mark - KVC

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (id)valueForUndefinedKey:(NSString *)key{return nil;}

- (void)setValue:(id)value forKey:(NSString *)key{

    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else if([key isEqualToString:@"avatar"]){
        ZXMainItemPhotoModel *item = [[ZXMainItemPhotoModel alloc]init];
        
        [item setValuesForKeysWithDictionary:value];
        
        _avatar = item;
    }else{
        [super setValue:value forKey:key];
    }
}

@end
