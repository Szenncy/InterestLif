//
//  ZXInterestViewController.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXInterestViewController.h"
#import "ZXTopBar.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "ZXNetWorking.h"
#import "ZXInterestTableViewCell.h"
#import "ZXInterestModel.h"
#import "ZXAlertView.h"
#import "UIView+Frame.h"
#import "ZXInterestItemModel.h"
#import "ZXLargeImageView.h"
#import "UIViewController+ZXTabBar.h"
#import "UIViewController+ZXNetWorking.h"
#import "ZXCommentViewController.h"

@interface ZXInterestViewController ()<UITableViewDataSource,UITableViewDelegate,ZXInterestTableViewCellDelegate>
{
    BOOL _isAnimating;
}

//上面弹出框
@property (weak, nonatomic)ZXAlertView *alerView;

//自定义的navbar
@property (weak, nonatomic) IBOutlet ZXTopBar *navBar;

//存储弹出的大图片
@property (weak, nonatomic)ZXLargeImageView *largeView;

//tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//存储数据源
@property (strong, nonatomic) ZXInterestModel *interestModel;

@end

@implementation ZXInterestViewController

#pragma mark - 初始化

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.title = @"也有意思";
        self.tabBarItem.image = [UIImage imageNamed:@"icon_2"];
        
    }
    return self;
}

//自定义导航栏的初始化
- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
    self.navBar.title = self.title;
}

//初始化下拉加载
- (void)initHeaderRefresh{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        self.interestModel = nil;
        
        [self.tableView reloadData];
        
        //初始化网络
        [self initNetWorking];
    }];
    
    self.tableView.header = header;
    
    //下拉
    [header setTitle:@"下拉刷新..." forState:MJRefreshStateIdle];
    
    header.stateLabel.font = [UIFont boldSystemFontOfSize:13];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setImages:@[[UIImage imageNamed:@"icon_arrow_down"]] forState:MJRefreshStateIdle];
    //松开
    [header setTitle:@"松开刷新..." forState:MJRefreshStatePulling];
    
    [header setImages:@[[UIImage imageNamed:@"icon_arrow_up"]] forState:MJRefreshStatePulling];
    
    //加载
    [header setTitle:@"正在载入..." forState:MJRefreshStateRefreshing];
    
    [header setImages:@[[UIImage imageNamed:@"icon_refresh_article"],[UIImage imageNamed:@"icon_refresh_stream"]] duration:1 forState:MJRefreshStateRefreshing];
    
    //开始更新
    [self.tableView.header beginRefreshing];
}

//初始化上拉刷新
- (void)initFooterRefresh{
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
         ZXInterestItemModel *item = [self.interestModel.data lastObject];
        
        NSDictionary *dict = @{KEY_DEVICE:VALUE_DEVICE,KEY_LT:item.added_on};
        
        [self netWorkingWithDict:dict];
    }];
    
    
    footer.gifView.hidden = YES;
    
    //下拉
    [footer setTitle:@"上拉加载更多..." forState:MJRefreshStateIdle];
    
    //松开
    [footer setTitle:@"可是松开了..." forState:MJRefreshStatePulling];
    
    self.tableView.footer = footer;
}

//初始化表视图
- (void)initTableView{
    //1.设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //2.注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ZXInterestTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

//初始化网络
- (void)initNetWorking{
    //1.初始化列表
    NSDictionary *list = @{KEY_DEVICE:VALUE_DEVICE};
    
    [self netWorkingWithDict:list];
    
    //2.开启网络监听
    [self netWorkingMonitorWithView:self.navBar];
}

#pragma mark - getter

//懒加载数据源
- (ZXInterestModel *)interestModel{
    if (!_interestModel) {
        _interestModel = [[ZXInterestModel alloc]init];
    }
    return _interestModel;
}

//懒加载上面弹出框
- (ZXAlertView *)alerView{
    if (!_alerView) {
        ZXAlertView *alerView = [[[NSBundle mainBundle] loadNibNamed:@"ZXAlertView" owner:self options:nil] lastObject];
        
        alerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
        
        [self.view addSubview:alerView];
        
        [self.view bringSubviewToFront:self.navBar];
        
        _alerView = alerView;
    }
    return _alerView;
}
//懒加载大图
- (ZXLargeImageView *)largeView{
    if (!_largeView) {
        ZXLargeImageView *largeView = [[ZXLargeImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        largeView.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:largeView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch:)];
        
        [largeView addGestureRecognizer:tapGesture];
        
        _largeView = largeView;
    }
    return _largeView;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.初始化自定义导航栏
    [self initNav];
    
    //2.初始化下拉加载
    [self initHeaderRefresh];
    
    //3.初始化上拉刷新
    [self initFooterRefresh];
    
    //4.初始化tableView
    [self initTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.tabBarViewController.tabBarView.hidden = NO;
}

#pragma mark - tableView代理

//table的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.interestModel.data.count;
}

//cell的视图
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXInterestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.item = self.interestModel.data[indexPath.row];
    
    //cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-add-comment-nav"]];
    
    cell.delegate = self;
    
    return cell;
}

//动态设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXInterestItemModel *item = self.interestModel.data[indexPath.row];
    
    return 58.5 + item.contentHeight + item.imageHeight;
    
}

#pragma mark - interestCell代理

//点击收藏的按钮
- (void)interestTableViewCell:(ZXInterestTableViewCell *)cell anddidSelectedCollection:(UIButton *)btn andModel:(ZXInterestItemModel *)model{
    
    model.selected = btn.selected;
    
    [self collectionWithBtn:btn];
}

//点击分享的按钮
- (void)interestTableViewCell:(ZXInterestTableViewCell *)cell anddidSelectedShare:(UIButton *)btn andModel:(ZXInterestItemModel *)model{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微信朋友圈",@"转给微信好友", nil];
    
    [actionSheet showInView:self.view];
}

//点击评论的按钮
- (void)interestTableViewCell:(ZXInterestTableViewCell *)cell anddidSelectedComment:(UIButton *)btn andModel:(ZXInterestItemModel *)model{
    
    ZXCommentViewController *vc = [[UIStoryboard storyboardWithName:@"CommentStoryboard" bundle:nil] instantiateInitialViewController];
    
    self.navigationController.tabBarViewController.tabBarView.hidden = YES;
    
    //NSLog(@"%@",[model.ID stringValue]);
    
    //NSString *str = [NSString stringWithFormat:@"%@",model.ID];
    
    vc.articleId = [model.ID stringValue];
    
    vc.style = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//点击图像
- (void)interestTableViewCell:(ZXInterestTableViewCell *)cell anddidSelectedImage:(UIImageView *)imageView andModel:(ZXInterestItemModel *)model{
    
    self.navigationController.tabBarViewController.tabBarView.hidden = YES;
    
    self.largeView.item = model;
    NSLog(@"--");
}

#pragma mark - 网络

- (void)netWorkingWithDict:(NSDictionary *)dict{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlPOSTS parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         if ([responseObject[@"success"] boolValue]) {
             [self.interestModel setValuesForKeysWithDictionary:responseObject];
             
             [self.tableView reloadData];
         }
         
         [self endRefresh];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
         
         [self endRefresh];
     }];
}

#pragma mark - 内部逻辑算法

//动画效果
- (void)animationInKeyWithTitle:(NSString *)title{
    
    self.alerView.title = title;
    
    if (_isAnimating) {
        return;
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        self.alerView.y = 44;
        self.alerView.height = 44;
        _isAnimating = YES;
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.alerView removeFromSuperview];
            _isAnimating = NO;
        });
        
    }];
}

//收藏
- (void)collectionWithBtn:(UIButton *)btn{
    
    
    
    if (btn.selected) {
        
        [self animationInKeyWithTitle:@"已收藏"];
        
    }else{
        
        [self animationInKeyWithTitle:@"取消收藏"];
    }
}

//取消刷新状态
- (void)endRefresh{
    if ([self.tableView.header isRefreshing]) {
        [self.tableView.header endRefreshing];
    }
    
    if ([self.tableView.footer isRefreshing]) {
        [self.tableView.footer endRefreshing];
    }
}

#pragma mark - 事件响应
//大图点击事件
- (void)tapTouch:(UITapGestureRecognizer *)gesture{
    
    self.navigationController.tabBarViewController.tabBarView.hidden = NO;
    
    [self.largeView removeFromSuperview];
    //NSLog(@"++");
}

#pragma mark - 状态栏
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
