//
//  ZXHelloModel.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXHelloModel.h"

@implementation ZXHelloModel

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
        for (NSDictionary *obj in value) {
            ZXHelloItemModel *item = [[ZXHelloItemModel alloc]init];
            
            [item setValuesForKeysWithDictionary:obj];
            
            [self.data addObject:item];
        }
    }
}

@end
