//
//  ZXMainLargeViewController.m
//  InterestLife
//
//  Created by zency on 15/9/22.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "ZXMainLargeViewController.h"
#import "ZXTopBar.h"
#import "ZXToolBar.h"
#import "UIViewController+ZXTabBar.h"
#import "ZXLargeDetailTableViewCell.h"
#import "ZXLargeTableViewHeader.h"
#import "ZXLargeTableViewFooter.h"
#import "ZXAlertView.h"
#import "UIView+Frame.h"
#import "ZXCommentViewController.h"

@interface ZXMainLargeViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    NSMutableArray *_items;
    BOOL _isAnimating;
}
//自定义toolBar
@property (weak, nonatomic) IBOutlet UIView *toolBar;
//自定义NavBar
@property (weak, nonatomic) IBOutlet ZXTopBar *navBar;
//tool类
@property (weak, nonatomic) ZXToolBar *tool;
//表示图
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//表头
@property (weak, nonatomic)ZXLargeTableViewHeader *tableHeader;
//表尾
@property (weak, nonatomic)ZXLargeTableViewFooter *tableFooter;
//下面弹出框
@property (weak, nonatomic)UIActionSheet *actionSheet;
//上面弹出框
@property (weak, nonatomic)ZXAlertView *alerView;

@end

@implementation ZXMainLargeViewController

#pragma mark - 初始化
//初始化Nav
- (void)initNav{
    self.navBar.layer.contents = (id)[UIImage imageNamed:@"bg_top_bar"].CGImage;
    
    self.navBar.title = self.item.tags;
    
    self.navBar.nowTime.hidden = YES;
    
    self.navigationController.tabBarViewController.tabBarView.hidden = YES;
    
    [self.navBar.leftButton setTitle:@"返回" forState:UIControlStateNormal];;
    
    [self.navBar.leftButton addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navBar.leftButton setImage:[UIImage imageNamed:@"icon_arrow_left"] forState:UIControlStateNormal];
}
//初始化ToolBar
- (void)initToolBar{
    self.toolBar.layer.contents = (id)[UIImage imageNamed:@"bg-nav"].CGImage;
    
    NSArray *arr = @[@"icon_nav_bookmark",@"icon_nav_share",@"icon_nav_pre",@"icon_nav_next"];
    
    self.tool.item = arr;
    
    ZXMainItemModel *item = self.items[self.page];
    
    self.tool.myselected = item.selected;
    
    //设置点击按钮的Block
    [self.tool setBtnTouchBlock:^(UIButton *btn) {
        switch (btn.tag - 618) {
            case ZXToolBarStateCollection:
                //[self collectionWithBtn:btn];{
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲!功能开在开发中哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alertView show];
            }
                break;
            case ZXToolBarStateShare:{
                //                [self.actionSheet showInView:self.view];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲!功能开在开发中哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                
                [alertView show];
            }
                break;
            case ZXToolBarStateInFont:
                [self pageInfont];
                break;
            case ZXToolBarStateNext:
                [self pageNext];
                break;
            default:
                break;
        }
    }];
}

//初始化tableView
- (void)initTableView{
    //1.设置代理对象
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //2.注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ZXLargeDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    //3.表头初始化
    [self.tableHeader awakeFromNib];
    
    self.tableHeader.item = self.item;
    
    //4.表尾初始化
    [self.tableFooter awakeFromNib];
    
}


#pragma mark - getter
//懒加载tool
- (ZXToolBar *)tool{
    if (!_tool) {
        ZXToolBar *tool = [[ZXToolBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
        
        [self.toolBar addSubview:tool];
        
        _tool = tool;
    }
    return _tool;
}

//懒加载表头
- (ZXLargeTableViewHeader *)tableHeader{
    if (!_tableHeader) {
        ZXLargeTableViewHeader *header = [[ZXLargeTableViewHeader alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80)];
        
        self.tableView.tableHeaderView = header;
        
        _tableHeader = header;
    }
    return _tableHeader;
}

//懒加载表尾
- (ZXLargeTableViewFooter *)tableFooter{
    if(!_tableFooter){
        ZXLargeTableViewFooter *footer = [[ZXLargeTableViewFooter alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 213)];
        
        self.tableView.tableFooterView = footer;
        
        [footer setCommentBlock:^(ZXMainItemModel *item) {
            self.navigationController.tabBarViewController.tabBarView.hidden = YES;
            
            ZXCommentViewController *vc = [[UIStoryboard storyboardWithName:@"CommentStoryboard" bundle:nil] instantiateInitialViewController];
            //获取当前对象
            ZXMainItemModel *model = self.items[self.page];
            
            vc.articleId = model.ID;
            
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [footer setShareWeChatBlock:^(ZXMainItemModel *item)
         {
             UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微信朋友圈",@"转给微信好友", nil];
             
             [actionSheet showInView:self.view];
         }];
        
        _tableFooter = footer;
    }
    return _tableFooter;
}

//懒加载item数组
- (NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

//懒加载actionSheet
- (UIActionSheet *)actionSheet{
    if (!_actionSheet) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微信朋友圈",@"转给微信好友",@"分享到新浪微博",@"分享到腾讯微博", nil];
        
        [self.view addSubview:actionSheet];
        
        _actionSheet = actionSheet;
    }
    return _actionSheet;
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

#pragma mark - setter

- (void)setItem:(ZXMainItemModel *)item{
    _item = item;
    
    self.tableView.contentOffset = CGPointMake(0, 0);
    
    self.navBar.title = self.item.tags;
    
    self.tableHeader.item = item;
    
    self.tableFooter.item = item;
    
    
}

- (void)setItems:(NSMutableArray *)items
{
    
    [self.items addObject:self.item];
    
    [_items addObjectsFromArray:items];
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.初始化Nav
    [self initNav];
    
    //2.初始化tool
    [self initToolBar];
    
    //3.初始化tableView
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.item.paragraphs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXLargeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.item = self.item.paragraphs[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZXMainItemParagraphsModel *model = self.item.paragraphs[indexPath.row];
    
    return 20 + model.contentHeight + model.imageHeight + model.titleHeight;
}
#pragma mark - 事件响应

- (void)btnTouch:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
    
    self.navigationController.tabBarViewController.tabBarView.hidden = NO;
}

#pragma mark - 内部逻辑算法

//向前翻页
- (void)pageInfont{
    if (self.page == 0) {
        
        [self animationInKeyWithTitle:@"已经是第一页了"];
        
        return ;
    }
    
    self.page --;
    
    self.item = _items[self.page];
    
    [self.tableView reloadData];
}

//向后翻页
- (void)pageNext{
    
    if (self.page >= _items.count - 1) {
        
        [self animationInKeyWithTitle:@"已经是最后一篇了"];
        
        return ;
    }
    
    self.page ++;
    
    self.item = _items[self.page];
    
    [self.tableView reloadData];
}

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
    
    ZXMainItemModel *item = _items[self.page];
    
    item.selected = btn.selected;
    
    NSLog(@"%d",item.selected);
    
    if (btn.selected) {
        
        [self animationInKeyWithTitle:@"已收藏"];
        
    }else{
        
        [self animationInKeyWithTitle:@"取消收藏"];
    }
}

#pragma mark - 状态栏
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
