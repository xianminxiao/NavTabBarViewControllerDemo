//
//  NavTabBarDelegate.h
//  NavTabBarViewControllerDemo
//
//  Created by xianminxiao on 17/3/18.
//  Copyright © 2017年 tencent. All rights reserved.
//

#ifndef NavTabBarDelegate_h
#define NavTabBarDelegate_h

#import <UIKit/UIKit.h>

@protocol NavTabBarDelegate <NSObject>

@optional
/**
 *  When NavTabBar Item Is Pressed Call Back
 *
 *  @param index - pressed item's index
 */
- (void)itemDidSelectedWithIndex:(NSInteger)index;

@end


#endif /* NavTabBarDelegate_h */

