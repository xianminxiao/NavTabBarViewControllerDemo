//
//  NavTabBarScrollView.m
//  NavTabBarViewControllerDemo
//
//  Created by xianminxiao on 17/3/18.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "NavTabBarScrollView.h"
#import "NavTabBarViewControllerDelegate.h"


@interface NavTabBarScrollView()<UIScrollViewDelegate>
{
    CGPoint _lastContentOffset;
}

@end

@implementation NavTabBarScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setDelaysContentTouches:NO];
        [self setCanCancelContentTouches:NO];
        self.delegate = self;
    }
    return self;
}

- (BOOL)bScrollViewContentOffsetTop
{
    return self.contentOffset.y >= 100;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _lastContentOffset = scrollView.contentOffset;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<_lastContentOffset.y)
    {
        // 向下滚动
        self.bounces = YES;
        if (_navTabBarControllerDelegate)
        {
            if (![self.navTabBarControllerDelegate bSelectedTabVCContentOffsetToTop])
            {
                [self setContentOffset:CGPointMake(_lastContentOffset.x, _lastContentOffset.y)];
            }
        }
        
    }
    else if (scrollView.contentOffset.y>_lastContentOffset.y)
    {
        // 向上滚动
        self.bounces = NO;
    }
}

@end
