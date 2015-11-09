//
//  ZXCommentViewController.m
//  InterestLife
//
//  Created by zency on 15/9/23.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXCommentViewController.h"
#import "UIViewController+ZXTabBar.h"
#import "ZXTopBar.h"
#import "ZXCommentTool.h"
#import "ZXCommentTableViewCell.h"
#import "AFNetworking.h"
#import "ZXNetWorking.h"
#import "ZXCommentModel.h"
#import "UIView+Frame.h"
#import "MJRefresh.h"
#import "ZXSayHiViewController.h"

@interface ZXCommentViewController ()<UITableViewDataSource,UITableViewDelegate,ZXCommentTableViewCellDelegate>

//自定义导航栏
@property (weak, nonatomic) IBOutlet ZXTopBar *navBar;

//评论框
@property (weak, nonatomic)ZXCommentTool *tool;

//表视图
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//cell
@property (strong, nonatomic)ZXCommentTableViewCell *cell;

//数据源
@property (strong, nonatomic)ZXCommentModel *commentModel;

@end

@implementation ZXCommentViewController

#pragma mark - 初始化

//初始化自定义导航栏
- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
    self.navBar.title = @"评论";
    
    self.navBar.nowTime.hidden = YES;
    
    [self.navBar.leftButton setTitle:@"返回" forState:UIControlStateNormal];;
    
    [self.navBar.leftButton addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navBar.leftButton setImage:[UIImage imageNamed:@"icon_arrow_left"] forState:UIControlStateNormal];
}

//初始化评论栏
- (void)initTool{
    self.tool.layer.contents = (id)[UIImage imageNamed:@"mmbang-bg"].CGImage;
}

//初始化TableView
- (void)initTableView{
    
    //1.设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //2.注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ZXCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
}

//初始化网络
- (void)initNetWorking{
    if (!self.style) {
        NSDictionary *dict = @{KEY_ARTICLEID:self.articleId};
        [self netWorkingWithDict:dict];
    }else{
        NSDictionary *dict = @{KEY_POSTID:self.articleId};
        [self netWorkingWithDict:dict];
    }
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
        ZXCommentTool *tool = [[[NSBundle mainBundle] loadNibNamed:@"ZXCommentTool" owner:self options:nil] lastObject];
        
        tool.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49);
        
        [self.navigationController.tabBarController.view addSubview:tool];
        
        _tool = tool;
        
    }
    return _tool;
}

//懒加载cell
- (ZXCommentTableViewCell *)cell{
    if (!_cell) {
        _cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    }
    return _cell;
}

//懒加载数据源
- (ZXCommentModel *)commentModel{
    if (!_commentModel) {
        _commentModel = [[ZXCommentModel alloc]init];
    }
    return _commentModel;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.初始化Nav
    [self initNav];
    
    //2.初始化评论栏
    [self initTool];
    
    //3.初始化TableView
    [self initTableView];
    
    //4.初始化网络
    [self initNetWorking];
    
    //5.初始化键盘
    [self initKeyBoard];
    
   /* UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲!有些功能开在开发中哦,敬请期待" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alertView show];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.tool.hidden = YES;
    self.tool.show = NO;
    [self.tool.contentTextField resignFirstResponder];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tool.hidden = NO;
}

- (void)dealloc{
    self.navigationController.tabBarViewController.tabBarView.hidden = NO;
}

#pragma mark - tableView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.commentModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.item = self.commentModel.data[indexPath.row];
    
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXCommentItemModel *item = self.commentModel.data[indexPath.item];
    
    return 80 + item.contentHeight + item.quoteHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXCommentItemModel *item = self.commentModel.data[indexPath.row];
    
    if (item.quote.content.length != 0) {
        
        [self.tool.contentTextField resignFirstResponder];
        
        self.tool.show = NO;
        
        UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"回复评论",@"回复引用的评论", nil];
        
        [action showInView:self.view];
    }else{
        [self.tool showKeyboard];
    }
    
}
#pragma mark - commentTableViewCell代理

- (void)commentTableViewCell:(ZXCommentTableViewCell *)cell anddidSelectUserInfo:(ZXCommentItemModel *)model{
    ZXSayHiViewController *vc = [[UIStoryboard storyboardWithName:@"SayHiStoryboard" bundle:nil] instantiateInitialViewController];
    
    vc.style = @"comment";
    
    vc.commentItem = model;
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 网络
- (void)netWorkingWithDict:(NSDictionary *)dict{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:self.style?urlSComment:urlComments parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.commentModel setValuesForKeysWithDictionary:responseObject];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - 事件响应

- (void)btnTouch:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
    
    self.navigationController.tabBarViewController.tabBarView.hidden = NO;
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


#pragma mark - 状态栏
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}


@end
