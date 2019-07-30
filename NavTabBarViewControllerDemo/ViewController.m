//
//  ViewController.m
//  NavTabBarViewControllerDemo
//
//  Created by xianminxiao on 17/3/18.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "ViewController.h"
#import "TableDataViewController.h"
#import "NavTabBarScrollView.h"
#import "CommonMacro.h"
#import "NavTabBarViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    TableDataViewController *zeroViewController = [[TableDataViewController alloc] initWithTitle:@"头条"];
    zeroViewController.title = @"头条";
    zeroViewController.view.backgroundColor = [UIColor grayColor];
    [zeroViewController disableScrollListToTop:YES];
    
    TableDataViewController *oneViewController = [[TableDataViewController alloc] initWithTitle:@"新闻"];
    oneViewController.title = @"新闻";
    oneViewController.view.backgroundColor = [UIColor brownColor];
    
    TableDataViewController *twoViewController = [[TableDataViewController alloc] initWithTitle:@"深圳"];
    twoViewController.title = @"深圳";
    twoViewController.view.backgroundColor = [UIColor purpleColor];
    
    TableDataViewController *threeViewController = [[TableDataViewController alloc] initWithTitle:@"莆田"];
    threeViewController.title = @"莆田";
    threeViewController.view.backgroundColor = [UIColor orangeColor];
    
    TableDataViewController *fourViewController = [[TableDataViewController alloc] initWithTitle:@"西安"];
    fourViewController.title = @"西安";
    fourViewController.view.backgroundColor = [UIColor magentaColor];
    
    TableDataViewController *fiveViewController = [[TableDataViewController alloc] initWithTitle:@"福建省"];
    fiveViewController.title = @"福建省";
    fiveViewController.view.backgroundColor = [UIColor yellowColor];
    
    TableDataViewController *sixViewController = [[TableDataViewController alloc] initWithTitle:@"国际新闻"];
    sixViewController.title = @"国际新闻";
    sixViewController.view.backgroundColor = [UIColor cyanColor];
    
    TableDataViewController *sevenViewController = [[TableDataViewController alloc] initWithTitle:@"卡哇伊"];
    sevenViewController.title = @"卡哇伊";
    sevenViewController.view.backgroundColor = [UIColor blueColor];
    
    TableDataViewController *eightViewController = [[TableDataViewController alloc] initWithTitle:@"个性化推荐"];
    eightViewController.title = @"个性化推荐";
    eightViewController.view.backgroundColor = [UIColor greenColor];
    
    TableDataViewController *ninghtViewController = [[TableDataViewController alloc] initWithTitle:@"自媒体"];
    ninghtViewController.title = @"自媒体";
    ninghtViewController.view.backgroundColor = [UIColor redColor];
    
    NavTabBarScrollView *childScrollView = [[NavTabBarScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    childScrollView.showsHorizontalScrollIndicator = NO;
    childScrollView.showsVerticalScrollIndicator = NO;
    childScrollView.contentSize = CGSizeMake(DOT_COORDINATE, SCREEN_HEIGHT+100);
    [self.view addSubview:childScrollView];
    childScrollView.scrollsToTop = NO;
    
    UIView *parentUIView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, ([UIScreen mainScreen].bounds.size.width), ([UIScreen mainScreen].bounds.size.height) - 100)];
    parentUIView.backgroundColor = [UIColor redColor];
    [childScrollView addSubview:parentUIView];
    
    NavTabBarViewController *navTabBarController = [[NavTabBarViewController alloc] init];
    navTabBarController.subViewControllers = @[zeroViewController, oneViewController, twoViewController, threeViewController, fourViewController, fiveViewController, sixViewController, sevenViewController, eightViewController, ninghtViewController];
    [navTabBarController addParentUIView:parentUIView parentController:self];
    navTabBarController.parentScrollView = childScrollView;
    
    childScrollView.navTabBarControllerDelegate = navTabBarController;
    
    
    
    // 创建 滑动 手势对象
    UISwipeGestureRecognizer *swipeUpOrange = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    // 滑动方向
    swipeUpOrange.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer:swipeUpOrange];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer
{
    
}


@end
