//
//  ZXPhoneCodeViewController.m
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXPhoneCodeViewController.h"

@interface ZXPhoneCodeViewController ()
@property (weak, nonatomic) IBOutlet UIView *navBar;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *done;

@end

@implementation ZXPhoneCodeViewController

#pragma mark - 初始化

- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
}

- (void)initBtn{
    self.sendBtn.layer.cornerRadius = 5;
    
    self.done.layer.cornerRadius = 5;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.初始化nav
    [self initNav];
    //2.初始化按钮
    [self initBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 事件响应

- (IBAction)btnClick:(id)sender {
    
    /*self.phoneTextField.enabled = NO;
    
    self.sendBtn.enabled = NO;
    
    self.codeTextField.hidden = NO;
    
    self.done.hidden = NO;
    */
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲!功能开在开发中哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];
    
}


- (IBAction)backBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
