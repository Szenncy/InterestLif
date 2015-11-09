//
//  ZXRootViewController.m
//  03-自定义TabBar
//
//  Created by 证翕 胡 on 15/8/20.
//  Copyright (c) 2015年 证翕 胡. All rights reserved.
//

#import "ZXRootViewController.h"
#import "UIViewController+ZXTabBar.h"

#define kTabBarHeight 49

@interface ZXRootViewController ()<ZXTabBarViewDelegate>

@end

@implementation ZXRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //装载数据
        
        
        self.viewControllers = [self controllerWithStoryBoardName:@[@"ZXMainStoryboard",@"ZXInterestStoryboard",@"ZXHelloStoryboard",@"ZXMoreStoryboard"]];
        
        //隐藏系统tabBar
        self.tabBar.hidden = YES;
    }
    
    return self;
}

-(ZXTabBarView *)tabBarView{
    if (!_tabBarView) {
        ZXTabBarView *tabBar = [ZXTabBarView tabBarViewWithDelegate:self];
        
        tabBar.frame = CGRectMake(0, self.view.frame.size.height - kTabBarHeight, self.view.frame.size.width, kTabBarHeight);
        
        tabBar.layer.contents = (id)[UIImage imageNamed:@"bg_article_nav"].CGImage;
        
        _tabBarView = tabBar;
        
        [self.view addSubview:tabBar];
        
    }
    return _tabBarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setViewControllers:(NSArray *)viewControllers{
    
    //这里要换位置,先有装载数据才行
    NSMutableArray *objs = [NSMutableArray array];
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *v = viewControllers[i];
        [objs addObject:v.tabBarItem];
    }
    
    self.tabBarView.tabBarItems = objs;
    
    [super setViewControllers:viewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tabBarView:(ZXTabBarView *)tabBarView andSelectedIndex:(NSInteger)index{
    self.selectedIndex = index;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    [self.tabBarView setCurrentSelected:selectedIndex];
}

- (NSArray *)controllerWithStoryBoardName:(NSArray *)name{
    
    NSMutableArray *objs = [NSMutableArray array];
    
    for (NSString *nibname in name) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:nibname bundle:nil];
        
        UINavigationController *nav = [storyBoard instantiateInitialViewController];
        
        nav.tabBarViewController = self;
        
        [objs addObject:nav];
    }
    
    return objs;
}

@end
