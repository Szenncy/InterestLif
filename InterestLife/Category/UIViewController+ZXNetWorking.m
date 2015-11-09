//
//  UIViewController+ZXNetWorking.m
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "UIViewController+ZXNetWorking.h"

@implementation UIViewController (ZXNetWorking)

//网络监听
- (void)netWorkingMonitorWithView:(ZXTopBar *)navBar{
    
    [NetworkStatusMonitor StartWithBlock:^(NSInteger NetworkStatus) {
        switch (NetworkStatus) {
            case WithoutNetwork: //没有网络
                [navBar.leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                break;
            case WifiNetwork: //wifi
                [navBar.leftButton setImage:[UIImage imageNamed:@"icon_wifi"] forState:UIControlStateNormal];
                break;
            case CDMA1xNetwork:
                [navBar.leftButton setImage:[UIImage imageNamed:@"icon_2g"] forState:UIControlStateNormal];
                break;
            case Edge:
                [navBar.leftButton setImage:[UIImage imageNamed:@"icon_2g"] forState:UIControlStateNormal];
                break;
            case GPRS:
                [navBar.leftButton setImage:[UIImage imageNamed:@"icon_2g"] forState:UIControlStateNormal];
                break;
            case LTE: //4G网络
                [navBar.leftButton setImage:[UIImage imageNamed:@"icon_4g"] forState:UIControlStateNormal];
                break;
            case UnknowNetwork: //不知名网络
                [navBar.leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                break;
            default:
                [navBar.leftButton setImage:[UIImage imageNamed:@"icon_3g"] forState:UIControlStateNormal];
                break;
        }
    }];
    
}


@end
