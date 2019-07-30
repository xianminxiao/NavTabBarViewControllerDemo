//
//  NavTabBarScrollView.h
//  NavTabBarViewControllerDemo
//
//  Created by xianminxiao on 17/3/18.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavTabBarViewControllerDelegate;



@interface NavTabBarScrollView : UIScrollView

@property (nonatomic, assign) id<NavTabBarViewControllerDelegate> navTabBarControllerDelegate;


- (BOOL)bScrollViewContentOffsetTop;

@end
