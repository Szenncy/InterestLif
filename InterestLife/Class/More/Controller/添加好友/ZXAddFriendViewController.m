//
//  ZXAddFriendViewController.m
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXAddFriendViewController.h"
#import "ZXTopBar.h"
#import "UIViewController+ZXTabBar.h"

@interface ZXAddFriendViewController ()

//自定义Nav
@property (weak, nonatomic)ZXTopBar *navBar;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation ZXAddFriendViewController


#pragma mark - 初始化

//初始化Nav
- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
    
    self.navBar.title = @"添加好友";
    
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

//初始化按钮
- (void)initButton{
    self.searchButton.layer.cornerRadius = 5;
}

- (void)dealloc{
    [self.navBar removeFromSuperview];
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.初始化Nav
    [self initNav];
    //2.初始化按钮
    [self initButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
