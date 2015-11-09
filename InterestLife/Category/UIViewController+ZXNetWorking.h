//
//  UIViewController+ZXNetWorking.h
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkStatusMonitor.h"
#import "ZXTopBar.h"

@interface UIViewController (ZXNetWorking)

//自定义网络监测
- (void)netWorkingMonitorWithView:(ZXTopBar *)navBar;

@end
