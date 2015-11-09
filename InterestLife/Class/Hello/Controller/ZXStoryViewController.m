//
//  ZXStoryViewController.m
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
#import "ZXStoryViewController.h"
#import "NSString+Addition.h"
#import "UIViewController+ZXTabBar.h"

@interface ZXStoryViewController ()
//视图的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

//自定义navbar
@property (weak, nonatomic) IBOutlet ZXTopBar *navBar;
//主视图
@property (weak, nonatomic) IBOutlet UIView *contentView;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//名字
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//性别
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
//省份
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
//城市
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
//图片的数组
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *contentImageViews;
//内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//笑脸的按钮
@property (weak, nonatomic) IBOutlet UIButton *smileButton;
//笑脸的Label
@property (weak, nonatomic) IBOutlet UILabel *smileLabel;
//距离
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
//距离的头标
@property (weak, nonatomic) IBOutlet UIImageView *distanceImageView;
//存储弹出的大图片
@property (weak, nonatomic)ZXLargeImageView *largeView;

@end

@implementation ZXStoryViewController

#pragma mark - 初始化

//自定义导航栏的初始化
- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
    
    self.navBar.title = self.item.user_name;
    
    self.navBar.nowTime.hidden = YES;
    
    [self.navBar.leftButton setTitle:@"返回" forState:UIControlStateNormal];;
    
    [self.navBar.leftButton addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navBar.leftButton setImage:[UIImage imageNamed:@"icon_arrow_left"] forState:UIControlStateNormal];
}

//内容
- (void)initContentView{
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

//数据
- (void)initData{
    //设置头像
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.item.avatar_url]];
    
    //设置头像点击手势
    self.iconImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconTouch:)];
    
    [self.iconImageView addGestureRecognizer:tap];
    
    //设置名字
    self.nameLabel.text = self.item.user_name;
    
    
    //设置性别
    self.sexImageView.image = [self.item.user_gender boolValue]?[UIImage imageNamed:@"icon_male"]:[UIImage imageNamed:@"icon_female"];
    
    //设置省份
    NSArray *objs = [self.item.loc_city componentsSeparatedByString:@" "];
    
    self.provinceLabel.text = objs[0];
    
    //设置城市
    self.cityLabel.text = objs[1];
    
    for (int i = 0; i < self.contentImageViews.count; i ++ )
    {
        [self.contentImageViews[i] sd_setImageWithURL:nil placeholderImage:nil];
        
        UIImageView *image = self.contentImageViews[i];
        
        image.userInteractionEnabled = NO;
    }
    
    /*if (self.item.imageHeight == 0){
        self.item.imageHeight.constant = 111;
    }else{
        self.item.imageHeight.constant = 0;
    }*/
    
    
    //设置图片
    for (int i = 0; i < [self.item.num_of_photos integerValue]; i ++ )
    {
        ZXHelloItemPhotoModel *photo = self.item.photos[i];
        
        [self.contentImageViews[i] sd_setImageWithURL:[NSURL URLWithString:photo.mobile_url ] placeholderImage:nil];
        
        [self.contentImageViews[i] setTag:618 + i];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch:)];
        
        [self.contentImageViews[i] addGestureRecognizer:tapGesture];
        
        UIImageView *image = self.contentImageViews[i];
        
        image.userInteractionEnabled = YES;
        
    }
    //设置内容
    
    if (self.item.content == nil) {
        self.contentLabel.text = @"";
    }else{
        self.contentLabel.text = self.item.content;
    }
    
    //设置时间
    self.timeLabel.text = self.item.time;
    
    self.smileButton.selected = self.item.selected;
    
    if (self.item.selected) {
        [self.smileButton setImage:[UIImage imageNamed:@"btn_liked"] forState:UIControlStateNormal];
    }else{
        [self.smileButton setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
    }
    //设置smileLabel
    
    if ([self.item.num_of_likes integerValue] == 0) {
        self.smileLabel.text = @"";
    }else{
        self.smileLabel.text = [self.item.num_of_likes stringValue];
    }
    
    CGSize size = [self.item.content sizeWithFont:[UIFont systemFontOfSize:15] andMaxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 28 * 2, MAXFLOAT)];

    self.contentHeight.constant = 260 - 20 + size.height;
    
    
    self.distanceLabel.text = self.item.distance;
    
    if (self.distanceLabel.text.length == 0) {
        self.distanceImageView.hidden = YES;
    }else{
        self.distanceImageView.hidden = NO;
    }
    
    [self.view layoutIfNeeded];
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

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.初始化Nav
    [self initNav];
    
    //2.ContentView
    [self initContentView];
    
    //3.初始化数据
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 事件响应
- (void)btnTouch:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
    
    self.navigationController.tabBarViewController.tabBarView.hidden = NO;
}

- (IBAction)smileBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    self.item.selected = sender.selected;
    
    if (sender.selected) {
        
        int page = [self.item.num_of_likes intValue];
        
        page ++ ;
        
        self.item.num_of_likes = @(page);
        
        self.smileLabel.text = [self.item.num_of_likes stringValue];
        [sender setImage:[UIImage imageNamed:@"btn_liked"] forState:UIControlStateNormal];
    }else{
        
        int page = [self.item.num_of_likes intValue];
        
        page -- ;
        
        if (page < 0) {
            page = 0;
        }
        
        self.item.num_of_likes = @(page);
        
        if ([self.item.num_of_likes intValue] == 0) {
            self.smileLabel.text = @"";
        }else{
            self.smileLabel.text = [self.item.num_of_likes stringValue];
        }
        
        [sender setImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
    }

    
}
//图片
- (void)tapTouch:(UITapGestureRecognizer *)gesture{
    ZXHelloItemPhotoModel *item = self.item.photos[gesture.view.tag - 618];
    
    self.largeView.imageUrlString = item.mobile_large_url;
}

//头像
- (void)tapIconTouch:(UITapGestureRecognizer *)gesture{
    self.navigationController.tabBarViewController.tabBarView.hidden = YES;
    
    ZXSayHiViewController *vc = [[UIStoryboard storyboardWithName:@"SayHiStoryboard" bundle:nil] instantiateInitialViewController];
    
    vc.item = self.item;
    vc.style = @"hello";
    
    [self.navigationController pushViewController:vc animated:YES];
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
