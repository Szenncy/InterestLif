//
//  ZXHelloItem.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXHelloItemModel.h"
#import "NSString+Addition.h"

#define KSPACE 8

@implementation ZXHelloItemModel

#pragma mark - KVC

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (id)valueForUndefinedKey:(NSString *)key{return nil;}

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }else if([key isEqualToString:@"content"]){
        _content = value;
        CGSize size = [_content sizeWithFont:[UIFont systemFontOfSize:15] andMaxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - KSPACE * 4, MAXFLOAT)];
        _contentHeight = size.height;
    }else if([key isEqualToString:@"photos"]){
        
        NSArray *arr = value;
        
        if (arr.count == 0) {
            _imageHeight = 111;
        }else{
            _imageHeight = 0;
        }
        
        NSMutableArray *objs = [NSMutableArray array];
        
        for (NSDictionary * obj in value) {
            ZXHelloItemPhotoModel *item = [[ZXHelloItemPhotoModel alloc]init];
            
            [item setValuesForKeysWithDictionary:obj];
            
            [objs addObject:item];
        }
        
        _photos = objs;
    }
    else{
        [super setValue:value forKey:key];
    }
}
@end
