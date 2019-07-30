//
//  NavTabBar.h
//  NavTabBarViewControllerDemo
//
//  Created by xianminxiao on 17/3/18.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavTabBarDelegate.h"

@interface NavTabBar : UIView

@property (nonatomic, weak  )   id<NavTabBarDelegate>  delegate;
@property (nonatomic, assign)   NSInteger              currentItemIndex;           // current selected item's index
@property (nonatomic, strong)   NSArray                *itemTitles;                // all items' title
@property (nonatomic, strong)   UIColor                *lineColor;                 // set the underscore color
@property (nonatomic, assign)   CGFloat                tabBarMarinLeftAndRight;    // tabbar margin left and right

/**
 *  Initialize Methods
 *
 *  @param frame - SCNavTabBar frame
 *
 *  @return Instance
 */
- (id)initWithFrame:(CGRect)frame;

/**
 *  Update Item Data
 */
- (void)updateData;

@end
