//
//  NavTabBarItemTableView.m
//  NavTabBarViewControllerDemo
//
//  Created by xianminxiao on 17/3/18.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "NavTabBarItemTableView.h"

@interface NavTabBarItemTableView()<UITableViewDelegate>
{
    CGPoint _lastContentOffset;
}

@end

@implementation NavTabBarItemTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.delegate = self;
        self.bounces = NO;
        
    }
    return self;
}

- (CGFloat)tableViewContentOffsetY
{
    return _lastContentOffset.y;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _lastContentOffset = scrollView.contentOffset;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<_lastContentOffset.y)
    {
        // 向下滚动
        
    }
    else if (scrollView.contentOffset.y>_lastContentOffset.y)
    {
        // 向上滚动
        if (_itemTableViewDelegate && [_itemTableViewDelegate respondsToSelector:@selector(bParentScrollViewTop)])
        {
            BOOL bTop = [_itemTableViewDelegate bParentScrollViewTop];
            if (!bTop)
            {
                [self setContentOffset:CGPointMake(_lastContentOffset.x, _lastContentOffset.y)];
            }
        }
    }
}

@end
