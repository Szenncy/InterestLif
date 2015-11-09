//
//  ZXFeedBackViewController.m
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXFeedBackViewController.h"
#import "ZXTopBar.h"
#import "UIViewController+ZXTabBar.h"

@interface ZXFeedBackViewController ()

//自定义Nav
@property (weak, nonatomic)ZXTopBar *navBar;
//电话号码
@property (weak, nonatomic) IBOutlet UITextField *phoneFieldText;
//反馈信息
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation ZXFeedBackViewController


#pragma mark - 初始化

//初始化Nav
- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
    
    self.navBar.title = @"意见反馈";
    
    self.navBar.nowTime.hidden = YES;
    
    self.navigationController.tabBarViewController.tabBarView.hidden = YES;
    
    [self.navBar.leftButton setTitle:@"返回" forState:UIControlStateNormal];;
    
    [self.navBar.leftButton addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navBar.leftButton setImage:[UIImage imageNamed:@"icon_arrow_left"] forState:UIControlStateNormal];
    
    [self.navBar.rightButton setTitle:@"提交" forState:UIControlStateNormal];
    
    [self.navBar.rightButton addTarget:self action:@selector(btnCommit:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)initTextView{
    
    self.backView.layer.contents = (id)[UIImage imageNamed:@"bg-rate"].CGImage;
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
    
    //2.初始化textView
    [self initTextView];
    
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

- (void)btnCommit:(UIButton *)btn{
   
}

#pragma mark - 状态栏

- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
