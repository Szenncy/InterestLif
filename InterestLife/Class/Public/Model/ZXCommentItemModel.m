//
//  ZXCommentItemModel.m
//  InterestLife
//
//  Created by zency on 15/9/24.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXCommentItemModel.h"

@implementation ZXCommentItemModel

#pragma mark - KVC

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (id)valueForUndefinedKey:(NSString *)key{return nil;}

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID =value;
    }else if([key isEqualToString:@"quote"]){
        
        ZXCommentItemModel *item = [[ZXCommentItemModel alloc]init];
        
        [item setValuesForKeysWithDictionary:value];
        
        _quote = item;
        
    }else if([key isEqualToString:@"user"]){
        ZXUserModel *user = [[ZXUserModel alloc]init];
        
        [user setValuesForKeysWithDictionary:value];
        
        _user = user;
    }
    else{
        [super setValue:value forKey:key];
    }

}

@end
