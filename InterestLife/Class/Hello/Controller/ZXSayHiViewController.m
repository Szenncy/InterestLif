//
//  ZXSayHiViewController.m
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXTopBar.h"
#import "AFNetworking.h"
#import "ZXNetWorking.h"
#import "ZXLargeImageView.h"
#import "UIImageView+WebCache.h"
#import "ZXSayHiViewController.h"
#import "UIViewController+ZXTabBar.h"

@interface ZXSayHiViewController ()

//自定义navbar
@property (weak, nonatomic) IBOutlet ZXTopBar *navBar;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//名字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//性别
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
//生日
@property (weak, nonatomic) IBOutlet UILabel *birthLabel;
//星座
@property (weak, nonatomic) IBOutlet UILabel *constellationLabel;
//sayHi
@property (weak, nonatomic) IBOutlet UIButton *sayHiBtn;
//存储弹出的大图片
@property (weak, nonatomic)ZXLargeImageView *largeView;
@end

@implementation ZXSayHiViewController
//自定义导航栏的初始化
- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
    
    self.navBar.title = @"说声Hi";
    
    self.navBar.nowTime.hidden = YES;
    
    [self.navBar.leftButton setTitle:@"返回" forState:UIControlStateNormal];;
    
    [self.navBar.leftButton addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navBar.leftButton setImage:[UIImage imageNamed:@"icon_arrow_left"] forState:UIControlStateNormal];
    
    [self.navBar.rightButton setImage:[UIImage imageNamed:@"btn_menu_new"] forState:UIControlStateNormal];
    
    [self.navBar.rightButton addTarget:self action:@selector(moreTouch:) forControlEvents:UIControlEventTouchUpInside];
}

//初始化网络
- (void)initNewWorking{
    
    NSLog(@"%@",self.item.mobile);
    
    NSDictionary *dict = @{KEY_CODE:VALUE_CODESAYHI,KEY_DEVICE:VALUE_DEVICE,KEY_FRIENDMOBILE:self.item.mobile};
    
    [self netWorkingWithDict:dict];
}

//初始化数据
- (void)initData{
    
    if ([self.style isEqualToString:@"hello"]) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.item.avatar_url]];
        
        self.nameLabel.text = self.item.user_name;
        
        //设置性别
        self.sexImageView.image = [self.item.user_gender boolValue]?[UIImage imageNamed:@"icon_male"]:[UIImage imageNamed:@"icon_female"];
    }
    else{
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.commentItem.user.avatar.mobile_url]];
        
        self.nameLabel.text = self.commentItem.nick_name;
        
        //设置性别
        //self.sexImageView.image = [self.item.user_gender boolValue]?[UIImage imageNamed:@"icon_male"]:[UIImage imageNamed:@"icon_female"];
        self.sexImageView.image = [UIImage imageNamed:@"icon_female"];
    }
    
}

//初始化视图
- (void)initView{
    self.sayHiBtn.layer.cornerRadius = 5;
    
    self.iconImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch:)];
    
    [self.iconImageView addGestureRecognizer:tapGesture];
}
#pragma mark - getter

//懒加载大图
- (ZXLargeImageView *)largeView{
    if (!_largeView) {
        ZXLargeImageView *largeView = [[ZXLargeImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        largeView.backgroundColor = [UIColor blackColor];
        
        [self.navigationController.tabBarViewController.view addSubview:largeView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLargeTouch:)];
        
        [largeView addGestureRecognizer:tapGesture];
        
        _largeView = largeView;
    }
    return _largeView;
}

#pragma mark - setter

- (void)setItem:(ZXHelloItemModel *)item{
    _item = item;
}


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.初始化自定义NavBar
    [self initNav];
    
    //2.初始化数据
    [self initData];
    
    //3.初始化按钮
    [self initView];
    
    //4.初始化网络
#warning 不知道code
    //[self initNewWorking];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
}

#pragma mark - 网络

- (void)netWorkingWithDict:(NSDictionary *)dict{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"%@",dict);
    
    [manager GET:urlUSERINFO parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *obj = responseObject[@"data"];
         
         //[obj writeToFile:@"/Users/zhengxihu/Desktop/sayHi.plist" atomically:YES];
         
         NSLog(@"%@",obj);
         
         //self.birthLabel.text = obj[@"decade"];
         //self.constellationLabel.text = obj[@"constellation"];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];
}
- (IBAction)sayHiTouch:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲!有些功能开在开发中哦,敬请期待" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];
}

#pragma mark - 事件响应

- (void)btnTouch:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
    
    self.navigationController.tabBarViewController.tabBarView.hidden = NO;
}

//sayHi响应
- (IBAction)sayHiClick:(id)sender {
}

//点击头像
- (void)tapTouch:(UITapGestureRecognizer *)gesture{
    
    self.largeView.imageUrlString = self.item.avatar_url;
}

- (void)moreTouch:(UIButton *)btn{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"屏蔽TA的信息", nil];
    
    [sheet showInView:self.view];
}

//大图点击事件
- (void)tapLargeTouch:(UITapGestureRecognizer *)gesture{
    
    [self.largeView removeFromSuperview];
    
    self.navigationController.tabBarViewController.tabBarView.hidden = NO;
    
    //[self.tableView reloadData];
}

#pragma mark - 状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
