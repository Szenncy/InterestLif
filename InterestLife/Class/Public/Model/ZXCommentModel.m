//
//  ZXCommentModel.m
//  InterestLife
//
//  Created by zency on 15/9/24.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXCommentModel.h"

@implementation ZXCommentModel

#pragma mark - getter

- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

#pragma mark - KVC

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (id)valueForUndefinedKey:(NSString *)key{return nil;}

- (void)setValue:(id)value forKey:(NSString *)key{

    if ([key isEqualToString:@"data"]) {
        
        for (NSDictionary *dict in value) {
            ZXCommentItemModel *item = [[ZXCommentItemModel alloc]init];
            
            [item setValuesForKeysWithDictionary:dict];
            
            [self.data addObject:item];
        }
        
    }else{
        [super setValue:value forKey:key];
    }
}

@end
