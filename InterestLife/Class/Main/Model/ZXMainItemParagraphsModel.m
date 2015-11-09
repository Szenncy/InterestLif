//
//  ZXMainItemParagraphsModel.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXMainItemParagraphsModel.h"
#import "NSString+Addition.h"
#import "ZXFrame.h"

@implementation ZXMainItemParagraphsModel

#pragma mark - KVC

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

- (id)valueForUndefinedKey:(NSString *)key{return nil;}

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"photo"]) {
        
        NSDictionary *obj = value;
        
        if (obj.count == 0) {
            _imageHeight = 0;
        }else{
            _imageHeight = 200;
        }
        
        ZXMainItemPhotoModel *item = [[ZXMainItemPhotoModel alloc]init];
        
        [item setValuesForKeysWithDictionary:value];
        
        _photo = item;
    }else if([key isEqualToString:@"content"]){
        _content = [NSString stringWithFormat:@"%@",value];
        
        CGSize size = [_content sizeWithFont:[UIFont systemFontOfSize:20] andMaxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - ZXSPACE * 2, MAXFLOAT)];
        
        _contentHeight = size.height;
    }else if([key isEqualToString:@"title"]){
        _title = value;
        
        CGSize size = [_title sizeWithFont:[UIFont systemFontOfSize:20] andMaxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - ZXSPACE * 2, MAXFLOAT)];
        
        _titleHeight = size.height;
    }
    else{
        [super setValue:value forKey:key];
    }
}
@end
