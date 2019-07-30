//
//  TableDataViewController.h
//  NavTabBarViewControllerDemo
//
//  Created by xianminxiao on 17/3/18.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavTabBarItemTableViewDelegate.h"

@interface TableDataViewController : UIViewController

@property (nonatomic, assign) id<NavTabBarItemTableViewDelegate>  subVCTableViewDelegate;

/**
 *  Initialize TableDataViewController Instance And Show Children View Controllers
 *
 *  @param title - set controllers
 *
 *  @return Instance
 */
- (id)initWithTitle:(NSString *)title;

- (CGFloat)viewControllerContentOffsetY;
- (void)disableScrollListToTop:(BOOL)disable;

@end
