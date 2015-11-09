//
//  ZXInterestItemModel.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXInterestItemModel.h"
#import "NSString+Addition.h"

#define KSPACE 8

@implementation ZXInterestItemModel

#pragma mark - KVC

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (id)valueForUndefinedKey:(NSString *)key{return nil;}

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else if([key isEqualToString:@"content"]){
        _content = value;
        
        //这里计算text的frame
       CGSize size = [_content sizeWithFont:[UIFont systemFontOfSize:17] andMaxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - KSPACE * 2, MAXFLOAT)];
        
        _contentHeight = size.height;
        
    }else if ([key isEqualToString:@"pic"]){
        //NSDictionary *obj = value;
        
        if ([value  isEqual: @""]) {
            _imageHeight = 0;
        }else{
            _imageHeight = 80;
        }
        
        _pic = value;
    }
    else{
        [super setValue:value forKey:key];
    }
}

@end
