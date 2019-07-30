//
//  NavTabBarViewController.h
//  NavTabBarViewControllerDemo
//
//  Created by xianminxiao on 17/3/18.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NavTabBarScrollView;

@interface NavTabBarViewController : UIViewController

@property (nonatomic, assign)   BOOL                 scrollAnimation;            // Default value: NO
@property (nonatomic, strong)   NSArray              *subViewControllers;        // An array of children view controllers
@property (nonatomic, strong)   UIColor              *navTabBarColor;            // Could not set [UIColor clear], if you set, NavTabbar will show initialize color
@property (nonatomic, strong)   UIColor              *navTabBarLineColor;
@property (nonatomic, strong)   NavTabBarScrollView  *parentScrollView;


/**
 *  Initialize SCNavTabBarViewController Instance And Show Children View Controllers
 *
 *  @param subViewControllers - set an array of children view controllers
 *          
 *  @return Instance
 */
- (id)initWithSubViewControllers:(NSArray *)subViewControllers;

/**
 *  Initialize SCNavTabBarViewController Instance And Show On The Parent View Controller
 *
 *  @param viewController - set parent view controller
 *
 *  @return Instance
 */
- (id)initWithParentViewController:(UIViewController *)viewController;

/**
 *  Initialize SCNavTabBarViewController Instance, Show On The Parent View Controller And Show On The Parent View Controller
 *
 *  @param subControllers - set an array of children view controllers
 *  @param viewController - set parent view controller
 *
 *  @return Instance
 */
- (id)initWithSubViewControllers:(NSArray *)subControllers andParentViewController:(UIViewController *)viewController;

/**
 *  Show On The Parent View Controller
 *
 *  @param viewController - set parent view controller
 */
- (void)addParentController:(UIViewController *)viewController;

- (void)addParentUIView:(UIView *)view parentController:(UIViewController *)viewController;

- (CGFloat)selectedTabVCContentOffsetY;

@end
