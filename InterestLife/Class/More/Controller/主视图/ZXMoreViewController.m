//
//  ZXMoreViewController.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXMoreViewController.h"
#import "ZXTopBar.h"
#import "UIViewController+ZXTabBar.h"

@interface ZXMoreViewController ()

//自定义navbar
@property (weak, nonatomic)ZXTopBar *navBar;
@property (weak, nonatomic) IBOutlet UITableViewCell *clearChat;
@property (weak, nonatomic) IBOutlet UITableViewCell *clearFile;

@end

@implementation ZXMoreViewController

#pragma mark - 初始化

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.title = @"更多";
        self.tabBarItem.image = [UIImage imageNamed:@"icon_4"];
    }
    return self;
}


//自定义导航栏的初始化
- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
    self.navBar.title = self.title;
    
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
    
    //1.初始化自定义Nav
    [self initNav];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch)];
    
    [self.clearChat addGestureRecognizer:tap
     ];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch)];
    
    [self.clearFile addGestureRecognizer:tap1
     ];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationController.tabBarViewController.tabBarView.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)tapTouch{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲!功能开在开发中哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];
}


#pragma mark - 状态栏
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
