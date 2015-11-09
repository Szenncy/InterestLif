//
//  ZXApplicationViewController.m
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXApplicationViewController.h"
#import "ZXTopBar.h"
#import "UIViewController+ZXTabBar.h"

@interface ZXApplicationViewController ()

//自定义Nav
@property (weak, nonatomic)ZXTopBar *navBar;

@end

@implementation ZXApplicationViewController

#pragma mark - 初始化

//初始化Nav
- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
    
    self.navBar.title = @"应用推荐";
    
    self.navBar.nowTime.hidden = YES;
    
    self.navigationController.tabBarViewController.tabBarView.hidden = YES;
    
    [self.navBar.leftButton setTitle:@"返回" forState:UIControlStateNormal];;
    
    [self.navBar.leftButton addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navBar.leftButton setImage:[UIImage imageNamed:@"icon_arrow_left"] forState:UIControlStateNormal];
}

#pragma mark - getter
- (ZXTopBar *)navBar{
    if (!_navBar) {
        ZXTopBar *view = [[ZXTopBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        
        [view awakeFromNib];
        
        [self.navigationController.view addSubview:view];
        
        _navBar = view;
    }
    return _navBar;
}


#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.初始化Nav
    [self initNav];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲!功能开在开发中哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self.navBar removeFromSuperview];
}

#pragma mark - 事件响应

- (void)btnTouch:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.navBar removeFromSuperview];
    
    self.navigationController.tabBarViewController.tabBarView.hidden = NO;
}

#pragma mark - 状态栏

- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
