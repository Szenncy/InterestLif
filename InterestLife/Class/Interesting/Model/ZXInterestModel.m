//
//  ZXInterestModel.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXInterestModel.h"

@implementation ZXInterestModel

#pragma mark - getter
//懒加载data
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
            ZXInterestItemModel *item = [[ZXInterestItemModel alloc]init];
            
            [item setValuesForKeysWithDictionary:obj];
            
            [self.data addObject:item];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
@end
