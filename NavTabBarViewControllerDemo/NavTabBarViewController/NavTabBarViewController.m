//
//  NavTabBarViewController.m
//  NavTabBarViewControllerDemo
//
//  Created by xianminxiao on 17/3/18.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "NavTabBarViewController.h"
#import "CommonMacro.h"
#import "NavTabBar.h"
#import "NavTabBarViewControllerDelegate.h"
#import "NavTabBarItemTableViewDelegate.h"
#import "TableDataViewController.h"
#import "NavTabBarScrollView.h"
#import "NavTabBarScrollViewDelegate.h"

@interface NavTabBarViewController () <UIScrollViewDelegate, NavTabBarDelegate, NavTabBarItemTableViewDelegate, NavTabBarViewControllerDelegate>
{
    NSInteger       _currentIndex;              // current page index
    NSMutableArray  *_titles;                   // array of children view controller's title
    
    NavTabBar       *_navTabBar;                // NavTabBar: press item on it to exchange view
    UIScrollView    *_mainView;                 // content view
}

@end

@implementation NavTabBarViewController

- (id)initWithSubViewControllers:(NSArray *)subViewControllers
{
    self = [super init];
    if (self)
    {
        _subViewControllers = subViewControllers;
    }
    return self;
}

- (id)initWithParentViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self)
    {
        [self addParentController:viewController];
    }
    return self;
}

- (id)initWithSubViewControllers:(NSArray *)subControllers andParentViewController:(UIViewController *)viewController;
{
    self = [self initWithSubViewControllers:subControllers];
    
    [self addParentController:viewController];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
#pragma mark -
- (void)initData
{
    // Iinitialize value
    _currentIndex = 0;
    _navTabBarColor = _navTabBarColor ? _navTabBarColor : NavTabbarColor;
    
    // Load all title of children view controllers
    _titles = [[NSMutableArray alloc] initWithCapacity:_subViewControllers.count];
    for (UIViewController *viewController in _subViewControllers)
    {
        [_titles addObject:viewController.title];
    }
}

- (void)initUI
{
    // Load NavTabBar and content view to show on window
    _navTabBar = [[NavTabBar alloc] initWithFrame:CGRectMake(DOT_COORDINATE, DOT_COORDINATE, SCREEN_WIDTH, NAV_TAB_BAR_HEIGHT)];
    _navTabBar.delegate = self;
    _navTabBar.backgroundColor = _navTabBarColor;
    _navTabBar.lineColor = _navTabBarLineColor;
    _navTabBar.itemTitles = _titles;
    _navTabBar.restorationIdentifier = @"NavTabBarController_NavTabBar";
    _navTabBar.tabBarMarinLeftAndRight = 10.0f;
    [_navTabBar updateData];
    
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, _navTabBar.frame.origin.y + _navTabBar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - _navTabBar.frame.origin.y - _navTabBar.frame.size.height - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    _mainView.restorationIdentifier = @"NavTabBarController_MainView";
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.bounces = NO;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake(SCREEN_WIDTH * _subViewControllers.count, DOT_COORDINATE);
    _mainView.scrollEnabled = NO;
    _mainView.scrollsToTop = NO;
    [self.view addSubview:_mainView];
    [self.view addSubview:_navTabBar];
    
    // Load children view controllers and add to content view
    [_subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        TableDataViewController *viewController = (TableDataViewController *)_subViewControllers[idx];
        viewController.view.frame = CGRectMake(idx * SCREEN_WIDTH, DOT_COORDINATE, SCREEN_WIDTH, _mainView.frame.size.height);
        [viewController setSubVCTableViewDelegate:self];
        [_mainView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
}

#pragma mark - Public Methods
#pragma mark -
- (void)setNavTabbarColor:(UIColor *)navTabbarColor
{
    // prevent set [UIColor clear], because this set can take error display
    CGFloat red, green, blue, alpha;
    if ([navTabbarColor getRed:&red green:&green blue:&blue alpha:&alpha] && !red && !green && !blue && !alpha)
    {
        navTabbarColor = NavTabbarColor;
    }
    _navTabBarColor = navTabbarColor;
}

- (void)addParentController:(UIViewController *)viewController
{
    // Close UIScrollView characteristic on IOS7 and later
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

- (void)addParentUIView:(UIView *)view parentController:(UIViewController *)viewController
{
    // Close UIScrollView characteristic on IOS7 and later
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [viewController addChildViewController:self];
    [view addSubview:self.view];
}

- (CGFloat)selectedTabVCContentOffsetY
{
    TableDataViewController *viewController = (TableDataViewController *)_subViewControllers[_currentIndex];
    return [viewController viewControllerContentOffsetY];
}

#pragma mark - Scroll View Delegate Methods
#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    _navTabBar.currentItemIndex = _currentIndex;
}

#pragma mark - NavTabBarDelegate Methods
#pragma mark -
- (void)itemDidSelectedWithIndex:(NSInteger)index
{
    [_mainView setContentOffset:CGPointMake(index * SCREEN_WIDTH, DOT_COORDINATE) animated:_scrollAnimation];
}

- (BOOL)bParentScrollViewTop
{
    return [_parentScrollView bScrollViewContentOffsetTop];
}

- (BOOL)bSelectedTabVCContentOffsetToTop
{
    return [self selectedTabVCContentOffsetY] <= 0.01;
}

@end
