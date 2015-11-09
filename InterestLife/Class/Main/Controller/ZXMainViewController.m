//
//  ZXMainViewController.m
//  InterestLife
//
//  Created by zency on 15/9/21.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXMainViewController.h"
#import "ZXTopBar.h"
#import "MJRefresh.h"
#import "ZXMainTableHeader.h"
#import "ZXMainTableViewCell.h"
#import "AFNetworking.h"
#import "ZXNetWorking.h"
#import "ZXMainModel.h"
#import "UIViewController+ZXNetWorking.h"
#import "UIView+Frame.h"
#import "ZXMainLargeViewController.h"

#define kCellHeight 100

@interface ZXMainViewController ()<UITableViewDataSource,UITableViewDelegate>

//自定义navBar
@property (weak, nonatomic) IBOutlet ZXTopBar *navBar;
//表视图
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//列表的数据源
@property (strong, nonatomic)ZXMainModel *mainModel;
//大视图的数据源
@property (strong, nonatomic)ZXMainItemModel *itemModel;
//表头
@property (weak, nonatomic)ZXMainTableHeader *tableHeader;

@end

@implementation ZXMainViewController

#pragma mark - 初始化

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.title = @"生活有意思";
        self.tabBarItem.image = [UIImage imageNamed:@"icon_1"];
        
    }
    return self;
}

//初始化自定义导航栏
- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
    self.navBar.title = self.title;
    
}

//初始化下拉加载
- (void)initHeaderRefresh{
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.mainModel.data removeAllObjects];
        
        [self.tableView reloadData];
        
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
        ZXMainItemModel *item = [self.mainModel.data lastObject];
        
        //1.初始化列表
        NSDictionary *list = @{KEY_DEVICE:VALUE_DEVICE,KEY_MOBILE:VALUE_MOBILE,KEY_ORDER:item.order};
        
        [self netWorkingWithDict:list];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"ZXMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    //3.设置tableViewHeader
    [self.tableHeader awakeFromNib];
    
}
//初始化网络
- (void)initNetWorking{
    //1.初始化列表
    NSDictionary *list = @{KEY_DEVICE:VALUE_DEVICE,KEY_MOBILE:VALUE_MOBILE};
    
    [self netWorkingWithDict:list];
    
    //2.初始化大视图
    NSDictionary *obj = @{KEY_DEVICE:VALUE_DEVICE,KEY_MOBILE:VALUE_MOBILE,KEY_FEATURED:@"1"};
    
    [self netWorkingWithDict:obj];
    
    //3.开启网络监听
    [self netWorkingMonitorWithView:self.navBar];
}

#pragma mark - getter

//懒加载列表的数据源
- (ZXMainModel *)mainModel{
    if (!_mainModel) {
        _mainModel = [[ZXMainModel alloc]init];
    }
    return _mainModel;
}

//懒加载item的数据源
- (ZXMainItemModel *)itemModel{
    if (!_itemModel) {
        _itemModel = [[ZXMainItemModel alloc]init];
    }
    return _itemModel;
}

//懒加载tableHeader
- (ZXMainTableHeader *)tableHeader{
    if (!_tableHeader) {
        ZXMainTableHeader *tableViewHeader = [[ZXMainTableHeader alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 200)];
        
        self.tableView.tableHeaderView = tableViewHeader;
        
        //添加手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTocuh:)];
        
        [tableViewHeader addGestureRecognizer:tapGesture];
        
        //按钮的事件响应
        [tableViewHeader setMoreButtonBlock:^{
            [self transfromLargeControllerWithItem:self.itemModel andIndex:0];
        }];
        
        _tableHeader = tableViewHeader;
    }
    return _tableHeader;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];

    //1.自定义导航栏
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

#pragma mark - TableView代理

//tableView的section中Cell的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mainModel.data.count;
}

//设置cell中的视图
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.item = self.mainModel.data[indexPath.row];
    
    cell.layer.contents = (id)[UIImage imageNamed:@"bg-nav"].CGImage;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXMainItemModel *item = self.mainModel.data[indexPath.row];
    
    [self transfromLargeControllerWithItem:item andIndex:indexPath.row + 1];
}


#pragma mark - 网络

- (void)netWorkingWithDict:(NSDictionary *)dict{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlLIST parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (!dict[KEY_FEATURED]) {
            if ([responseObject[@"success"] boolValue]) {
                
                NSDictionary *dict = responseObject;
                
                [dict writeToFile:@"/Users/zhengxihu/Desktop/test.plist" atomically:YES];
                
                [self.mainModel setValuesForKeysWithDictionary:responseObject];
                
                if ([self.tableView.header isRefreshing]&&self.mainModel) {
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.tableView.header endRefreshing];
                    });
                    
                }
                
                if ([self.tableView.footer isRefreshing]&&self.mainModel) {
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.tableView.footer endRefreshing];
                    });
                    
                }
                
                //刷新tableView
                [self.tableView reloadData];
                
            }
        }else{
            if ([responseObject[@"success"] boolValue]) {
                
                [self.itemModel setValuesForKeysWithDictionary:responseObject[@"data"][0]];
                
                //更改大视图数据
                [self.tableHeader setValue:self.itemModel forKey:@"item"];
            }
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark - 事件相应事件
- (void)tapTocuh:(id)sender{
    [self transfromLargeControllerWithItem:self.itemModel andIndex:0];
}


#pragma mark - 内部逻辑方法

- (void)transfromLargeControllerWithItem:(ZXMainItemModel *)item andIndex:(NSInteger )index{
    ZXMainLargeViewController *vc = [[UIStoryboard storyboardWithName:@"ZXMainLargeStoryboard" bundle:nil] instantiateInitialViewController];
    
    vc.item = item;
    
    vc.page = index;
    
    [vc setItems:self.mainModel.data];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 状态栏
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
