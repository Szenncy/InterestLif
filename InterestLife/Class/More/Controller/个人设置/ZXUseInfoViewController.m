//
//  ZXUseInfoViewController.m
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXUseInfoViewController.h"
#import "ZXTopBar.h"
#import "UIViewController+ZXTabBar.h"
#import "ZXCheckPhone.h"

@interface ZXUseInfoViewController ()

//自定义Nav
@property (weak, nonatomic)ZXTopBar *navBar;
//检验登陆
@property (weak, nonatomic)ZXCheckPhone *checkPhone;

@end

@implementation ZXUseInfoViewController

#pragma mark - 初始化

//初始化Nav
- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
    
    self.navBar.title = @"个人设置";
    
    self.navBar.nowTime.hidden = YES;
    
    self.navigationController.tabBarViewController.tabBarView.hidden = YES;
    
    [self.navBar.leftButton setTitle:@"返回" forState:UIControlStateNormal];;
    
    [self.navBar.leftButton addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navBar.leftButton setImage:[UIImage imageNamed:@"icon_arrow_left"] forState:UIControlStateNormal];
}

#pragma mark - getter
//懒加载navBar
- (ZXTopBar *)navBar{
    if (!_navBar) {
        ZXTopBar *view = [[ZXTopBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        
        [view awakeFromNib];
        
        [self.navigationController.view addSubview:view];
        
        _navBar = view;
    }
    return _navBar;
}
//懒加载checkPhone
- (ZXCheckPhone *)checkPhone{
    if (!_checkPhone) {
        ZXCheckPhone *checkPhone = [[ZXCheckPhone alloc]initWithFrame:self.view.bounds];
        
        [checkPhone setCheckPhoneBlock:^{
            
            [self presentViewController:[[UIStoryboard storyboardWithName:@"PhoneCodeStoryboard" bundle:nil] instantiateInitialViewController] animated:YES completion:nil];
            
        }];
        
        [self.view addSubview:checkPhone];
        
        _checkPhone = checkPhone;
    }
    return _checkPhone;
}


#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.初始化Nav
    [self initNav];
    
    //2.检验
    [self checkPhone];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self.navBar removeFromSuperview];
}

#pragma mark - nav



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
