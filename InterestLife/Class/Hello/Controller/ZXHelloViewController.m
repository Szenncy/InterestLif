//
//  ZXHelloViewController.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//


#import "ZXTopBar.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "ZXNetWorking.h"
#import "ZXHelloModel.h"
#import "UIView+Frame.h"
#import "ZXCommentTool.h"
#import "ZXLargeImageView.h"
#import "ZXSayHiViewController.h"
#import "ZXHelloViewController.h"
#import "ZXStoryViewController.h"
#import "ZXCommentViewController.h"
#import "ZXHelloMoreTableViewCell.h"
#import "ZXHelloLargeTableViewCell.h"
#import "UIViewController+ZXTabBar.h"
#import "UIViewController+ZXNetWorking.h"

@interface ZXHelloViewController ()<UITableViewDataSource,UITableViewDelegate,ZXHelloLargeTableViewCellDelegate,ZXHelloMoreTableViewCellDelegate>
//自定义navbar
@property (weak, nonatomic) IBOutlet ZXTopBar *navBar;
//存储tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//存储数据源
@property (strong, nonatomic)ZXHelloModel *helloModel;
//存储弹出的大图片
@property (weak, nonatomic)ZXLargeImageView *largeView;
//评论框
@property (weak, nonatomic)ZXCommentTool *tool;

@end

@implementation ZXHelloViewController

#pragma mark - 初始化

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.title = @"Hi,你好";
        self.tabBarItem.image = [UIImage imageNamed:@"icon_3"];

    }
    return self;
}

//自定义导航栏的初始化
- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
    self.navBar.title = self.title;
    
    [self.navBar.rightButton setImage:[UIImage imageNamed:@"btn-camera-new"] forState:UIControlStateNormal];
    
    [self.navBar.rightButton addTarget:self action:@selector(cameraTouch:) forControlEvents:UIControlEventTouchUpInside];
}

//初始化下拉加载
- (void)initHeaderRefresh{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        self.helloModel = nil;
        
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
        NSDictionary *obj = @{KEY_CODE:VALUE_CODE,KEY_DEVICE:VALUE_DEVICE,KEY_ISREFRESH:@"0"};
        
        [self netWorkingWithDict:obj];
    }];
    
    
    footer.gifView.hidden = YES;
    
    //下拉
    [footer setTitle:@"上拉加载更多..." forState:MJRefreshStateIdle];
    
    //松开
    [footer setTitle:@"可是松开了..." forState:MJRefreshStatePulling];
    
    self.tableView.footer = footer;
}

//初始化网络
- (void)initNetWorking{
    //初始化列表
   // NSDictionary *list = @{KEY_DEVICE:VALUE_DEVICE,KEY_MOBILE:VALUE_MOBILE};
    
   // [self netWorkingWithDict:list];
    
    //初始化大视图
    NSDictionary *obj = @{KEY_CODE:VALUE_CODE,KEY_DEVICE:VALUE_DEVICE,KEY_ISREFRESH:@"1"};
    
    [self netWorkingWithDict:obj];
    
    //2.开启网络监听
    [self netWorkingMonitorWithView:self.navBar];
}

//初始化tableView
- (void)initTableView{
    //1.设置代理对象
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //2.注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ZXHelloLargeTableViewCell" bundle:nil] forCellReuseIdentifier:@"LargeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZXHelloMoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"MoreCell"];
}

//初始化键盘
- (void)initKeyBoard{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark - getter
//懒加载评论栏
- (ZXCommentTool *)tool{
    if (!_tool) {
        ZXCommentTool *tool = [[[NSBundle mainBundle] loadNibNamed:@"ZXCommentTool" owner:self options:nil]lastObject];
        
        tool.layer.contents = (id)[UIImage imageNamed:@"mmbang-bg"].CGImage;
        
        tool.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49);
        
        [self.navigationController.view addSubview:tool];
        
        _tool = tool;
        
    }
    return _tool;
}

//懒加载模型
- (ZXHelloModel *)helloModel{
    if (!_helloModel) {
        _helloModel = [[ZXHelloModel alloc]init];
    }
    return _helloModel;
}

//懒加载大图
- (ZXLargeImageView *)largeView{
    if (!_largeView) {
        ZXLargeImageView *largeView = [[ZXLargeImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        largeView.backgroundColor = [UIColor blackColor];
        
        [self.navigationController.tabBarViewController.view addSubview:largeView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch:)];
        
        [largeView addGestureRecognizer:tapGesture];
        
        _largeView = largeView;
    }
    return _largeView;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.初始化自定义NavBar
    [self initNav];
    
    //2.初始化下拉加载
    [self initHeaderRefresh];
    
    //3.初始化上拉刷新
    [self initFooterRefresh];
    
    //4.初始化tableView
    [self initTableView];
    
    //5.初始化键盘
    [self initKeyBoard];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.tabBarViewController.tabBarView.hidden = NO;
    [self.tableView reloadData];
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.helloModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXHelloItemModel *item = self.helloModel.data[indexPath.row];
    
    if ([item.num_of_photos integerValue]>2) {
        //more
        ZXHelloMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreCell" forIndexPath:indexPath];
        
        cell.item = item;
        
        cell.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        //large
        ZXHelloLargeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LargeCell" forIndexPath:indexPath];
        
        cell.item = item;
        
        cell.delegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXHelloItemModel *item = self.helloModel.data[indexPath.row];
    
    if ([item.num_of_photos integerValue] > 2) {
        //more
        
        if (item.content.length != 0 ) {
            return 230 - 13 + item.contentHeight - item.imageHeight;
        }else{
            return 230 - 13 - item.imageHeight;
        }
        
    }else{
        //large xib总高度 - 
        if (item.content.length != 0 ) {
            return 255 - 13 + item.contentHeight - item.imageHeight;
        }else{
           
            return 255 - 13 - item.imageHeight;
        }
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tool.show = NO;
    
    [self.tool.contentTextField resignFirstResponder];
    
    self.tool.hidden = YES;
    
}

#pragma mark - large的代理

//点击笑脸
- (void)helloLargeTableViewCell:(ZXHelloLargeTableViewCell *)cell anddidSelectedSmile:(UIButton *)btn andModel:(ZXHelloItemModel *)model{
    
}

//点击故事
- (void)helloLargeTableViewCell:(ZXHelloLargeTableViewCell *)cell anddidSelectedStory:(UIButton *)btn andModel:(ZXHelloItemModel *)model{
    
    self.navigationController.tabBarViewController.tabBarView.hidden = YES;
    
    id vc = nil;
    
    if (model.photos.count > 2) {
        vc = [[UIStoryboard storyboardWithName:@"MoreStoryStoryboard" bundle:nil] instantiateInitialViewController];
    }else {
        vc = [[UIStoryboard storyboardWithName:@"StoryStoryboard" bundle:nil] instantiateInitialViewController];
    }
    
    [vc setValue:model forKey:@"item"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

//点击评论
- (void)helloLargeTableViewCell:(ZXHelloLargeTableViewCell *)cell anddidSelectedComment:(UIButton *)btn andModel:(ZXHelloItemModel *)model{
    self.tool.hidden = NO;
    [self.tool showKeyboard];
    if (!self.tool.show) {
        [self.tool removeFromSuperview];
    }
}

//点击图片
- (void)helloLargeTableViewCell:(ZXHelloLargeTableViewCell *)cell anddidSelectedImage:(UIButton *)btn andModel:(ZXHelloItemModel *)model andIndex:(NSInteger)index{
    
    ZXHelloItemPhotoModel *item = model.photos[index];
    
    self.largeView.imageUrlString = item.mobile_large_url;
    
}

//点击头像
- (void)helloLargeTableViewCell:(ZXHelloLargeTableViewCell *)cell anddidSelectedIconImage:(UIImageView *)image andModel:(ZXHelloItemModel *)model{
    
    self.navigationController.tabBarViewController.tabBarView.hidden = YES;
    
    ZXSayHiViewController *vc = [[UIStoryboard storyboardWithName:@"SayHiStoryboard" bundle:nil] instantiateInitialViewController];
    
    vc.item = model;
    
    vc.style = @"hello";
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 网络
- (void)netWorkingWithDict:(NSDictionary *)dict{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlPOSTPOSTS parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         NSDictionary *dict = responseObject;
         
         [dict writeToFile:@"/Users/zhengxihu/Desktop/hello.plist" atomically:YES];
         
         if ([responseObject[KEY_SUCCESS] boolValue]) {
             [self.helloModel setValuesForKeysWithDictionary:responseObject];
             
             [self.tableView reloadData];
         }
         
         [self endRefresh];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
     }];
}

#pragma mark - 内部逻辑运算

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
    
    [self.largeView removeFromSuperview];
    
    self.navigationController.tabBarViewController.tabBarView.hidden = NO;
    
    [self.tableView reloadData];
}

//键盘显示的时候，按钮向上跑，不会被遮盖
-(void)keyboardShow:(NSNotification*)notification{
    
    NSDictionary* info = [notification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    self.tool.y = [UIScreen mainScreen].bounds.size.height - kbSize.height - 49;
}

//键盘隐藏是，按钮向下回到原先的位置
-(void)keyboardHide{
    self.tool.y = [UIScreen mainScreen].bounds.size.height - 49;
}

- (void)cameraTouch:(UIButton *)btn{
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消 " destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    
    [action showInView:self.view];
}

#pragma mark - 状态栏
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
