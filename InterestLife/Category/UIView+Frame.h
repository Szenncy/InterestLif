//
//  UIView+Frame.h
//  QQ列表Demo
//
//  Created by 证翕 胡 on 15/8/11.
//  Copyright (c) 2015年 证翕 胡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/**
 *  修改x坐标
 */
@property (assign, nonatomic)CGFloat x;

/**
 *  修改y坐标
 */
@property (assign, nonatomic)CGFloat y;

/**
 *  修改宽度
 */
@property (assign, nonatomic)CGFloat width;

/**
 *  修改高度
 */
@property (assign, nonatomic)CGFloat height;

/**
 *  修改坐标
 */
@property (assign, nonatomic)CGPoint origin;

/**
 *  修改大小
 */
@property (assign, nonatomic)CGSize size;

/**
 *  中间的X
 */
@property (assign, nonatomic, readonly)CGFloat midX;

/**
 *  中间的Y
 */
@property (assign, nonatomic, readonly)CGFloat midY;

/**
 *  最大的X
 */
@property (assign, nonatomic, readonly)CGFloat maxX;

/**
 *  最大的Y
 */
@property (assign, nonatomic, readonly)CGFloat maxY;

@end
