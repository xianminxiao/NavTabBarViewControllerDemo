//
//  NavTabBarItemTableView.h
//  NavTabBarViewControllerDemo
//
//  Created by xianminxiao on 17/3/18.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavTabBarItemTableViewDelegate.h"


@interface NavTabBarItemTableView : UITableView

@property (nonatomic, assign) id<NavTabBarItemTableViewDelegate> itemTableViewDelegate;

- (CGFloat)tableViewContentOffsetY;

@end
