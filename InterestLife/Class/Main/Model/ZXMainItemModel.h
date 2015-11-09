//
//  ZXMainItemModel.h
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXMainItemParagraphsModel.h"
#import "ZXMainItemPhotoModel.h"

@interface ZXMainItemModel : NSObject

//文章的种类
@property (copy, nonatomic)NSString *article_type;

//作者
@property (copy, nonatomic)NSString *author;

//图片的地址
@property (copy, nonatomic)NSString *icon_url;

//评论的数量
@property (copy, nonatomic)NSString *num_of_comments;

//排序
@property (strong, nonatomic)NSNumber *order;

//段落
@property (strong, nonatomic)NSArray *paragraphs;

//照片
@property (strong, nonatomic)ZXMainItemPhotoModel *photo;

//分享内容
@property (copy, nonatomic)NSString *share_contents;

//总结
@property (copy, nonatomic)NSString *summary;

//支持的设备
@property (copy, nonatomic)NSString *support_device;

//标签
@property (copy, nonatomic)NSString *tags;

//主题
@property (copy, nonatomic)NSString *title;

//用户
@property (copy, nonatomic)NSString *user;

//网站的url
@property (copy, nonatomic)NSString *web_url;

//id
@property (copy, nonatomic)NSString *ID;

//被选中
@property (assign, nonatomic)BOOL selected;

@end
