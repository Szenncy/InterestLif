//
//  ZXMainItemModel.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXMainItemModel.h"

@implementation ZXMainItemModel

#pragma mark - KVC

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (id)valueForUndefinedKey:(NSString *)key{return nil;}

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"paragraphs"]) {
        
        NSMutableArray *objs = [NSMutableArray array];
        
        for (NSDictionary *obj in value) {
            ZXMainItemParagraphsModel *item = [[ZXMainItemParagraphsModel alloc]init];
            
            [item setValuesForKeysWithDictionary:obj];
            
            [objs addObject:item];
        }
        
        _paragraphs = objs;
        
    }else if([key isEqualToString:@"photo"]){
        
        ZXMainItemPhotoModel *item = [[ZXMainItemPhotoModel alloc]init];
        
        [item setValuesForKeysWithDictionary:value];
        
        _photo = item;
        
    }else if([key isEqualToString:@"id"]){
        _ID = value;
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end
