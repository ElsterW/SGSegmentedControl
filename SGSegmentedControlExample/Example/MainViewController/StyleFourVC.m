//
//  StyleFourVC.m
//  SGSegmentedControlExample
//
//  Created by Sorgle on 2016/10/6.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

#import "StyleFourVC.h"
#import "SGSegmentedControl.h"
#import "TestOneVC.h"
#import "TestTwoVC.h"
#import "TestThreeVC.h"
#import "TestFourVC.h"
#import "TestFiveVC.h"
#import "TestSixVC.h"
#import "TestSevenVC.h"
#import "TestEightVC.h"
#import "TestNineVC.h"

@interface StyleFourVC ()<UIScrollViewDelegate, SGSegmentedControlDelegate>
@property (nonatomic, strong) SGSegmentedControl *SG;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@end

@implementation StyleFourVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    [self setupSegmentedControl];
}

- (void)setupSegmentedControl {
    NSArray *title_arr = @[@"精选", @"电视剧", @"电影", @"综艺", @"NBA", @"新闻", @"娱乐", @"音乐", @"网络电影"];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * title_arr.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    _mainScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    _mainScrollView.bounces = NO;
    // 隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    _mainScrollView.delegate = self;
    [self.view addSubview:_mainScrollView];
    
    TestOneVC *oneVC = [[TestOneVC alloc] init];
    [self.mainScrollView addSubview:oneVC.view];
    [self addChildViewController:oneVC];
    
    self.SG = [SGSegmentedControl segmentedControlWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44) delegate:self segmentedControlType:(SGSegmentedControlTypeScroll) titleArr:title_arr];
    _SG.indicatorColor = [UIColor blueColor];
    _SG.segmentedControlIndicatorType = SGSegmentedControlIndicatorTypeCenter;
    [self.view addSubview:_SG];
}


- (void)SGSegmentedControl:(SGSegmentedControl *)segmentedControl didSelectBtnAtIndex:(NSInteger)index {
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:index];
}

// 添加所有子控制器
- (void)setupChildViewController {
    // 精选
    TestOneVC *oneVC = [[TestOneVC alloc] init];
    [self addChildViewController:oneVC];
    
    // 电视剧
    TestTwoVC *twoVC = [[TestTwoVC alloc] init];
    [self addChildViewController:twoVC];
    
    // 电影
    TestThreeVC *threeVC = [[TestThreeVC alloc] init];
    [self addChildViewController:threeVC];
    
    // 综艺
    TestFourVC *fourVC = [[TestFourVC alloc] init];
    [self addChildViewController:fourVC];
    
    // NBA
    TestFiveVC *fiveVC = [[TestFiveVC alloc] init];
    [self addChildViewController:fiveVC];
    
    // 新闻
    TestSixVC *sixVC = [[TestSixVC alloc] init];
    [self addChildViewController:sixVC];
    
    // 娱乐
    TestSevenVC *sevenVC = [[TestSevenVC alloc] init];
    [self addChildViewController:sevenVC];
    
    // 音乐
    TestEightVC *eightVC = [[TestEightVC alloc] init];
    [self addChildViewController:eightVC];
    
    // 网络电视
    TestNineVC *nineVC = [[TestNineVC alloc] init];
    [self addChildViewController:nineVC];
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    [self.SG titleBtnSelectedWithScrollView:scrollView];
}


@end


