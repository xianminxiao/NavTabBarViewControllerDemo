//
//  NavTabBar.m
//  NavTabBarViewControllerDemo
//
//  Created by xianminxiao on 17/3/18.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "NavTabBar.h"
#import "CommonMacro.h"

#define BUTTON_ITEM_PADDING_WIDTH       40.0f

@interface NavTabBar ()
{
    UIScrollView     *_navgationTabBar;      // all items on this scroll view
    UIView           *_line;                 // underscore show which item selected
    NSMutableArray   *_items;                // NavTabBar pressed item array
    NSArray          *_itemsWidth;           // an array of items' width
    UIView           *_hSeparatorLine;       // horizontal rule
}

@end

@implementation NavTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _items = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

#pragma mark -
#pragma mark - Public Methods

- (void)setCurrentItemIndex:(NSInteger)currentItemIndex
{
    _currentItemIndex = currentItemIndex;
    UIButton *button = _items[currentItemIndex];
    
    if (button.frame.origin.x + button.frame.size.width > SCREEN_WIDTH)
    {
        CGFloat offsetX = button.frame.origin.x + button.frame.size.width - SCREEN_WIDTH;
        if (_currentItemIndex < [_itemTitles count] - 1)
        {
            offsetX = offsetX + BUTTON_ITEM_PADDING_WIDTH;
        }
        
        [_navgationTabBar setContentOffset:CGPointMake(offsetX, DOT_COORDINATE) animated:YES];
    }
    else
    {
        [_navgationTabBar setContentOffset:CGPointMake(DOT_COORDINATE, DOT_COORDINATE) animated:YES];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        _line.frame = CGRectMake(button.frame.origin.x + 2.0f, _line.frame.origin.y, [_itemsWidth[currentItemIndex] floatValue] - 4.0f, _line.frame.size.height);
    }];
}

- (void)setTabBarMarinLeftAndRight:(CGFloat)tabBarMarinLeftAndRight
{
    CGRect navigationTabBarRect = _navgationTabBar.frame;
    navigationTabBarRect.origin.x = tabBarMarinLeftAndRight;
    navigationTabBarRect.size.width = self.frame.size.width - 2*tabBarMarinLeftAndRight;
    _navgationTabBar.frame = navigationTabBarRect;
    
    CGRect hSeparatorLineRect = _hSeparatorLine.frame;
    hSeparatorLineRect.origin.x = tabBarMarinLeftAndRight;
    hSeparatorLineRect.size.width = _navgationTabBar.frame.size.width;
    _hSeparatorLine.frame = hSeparatorLineRect;
    
}

- (void)updateData
{
    _itemsWidth = [self getButtonsWidthWithTitles:_itemTitles];
    if (_itemsWidth.count)
    {
        CGFloat contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth];
        _navgationTabBar.contentSize = CGSizeMake(contentWidth, DOT_COORDINATE);
    }
}

#pragma mark -
#pragma mark - Private Methods

- (void)initUI
{
    _navgationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, DOT_COORDINATE, SCREEN_WIDTH, NAV_TAB_BAR_HEIGHT)];
    _navgationTabBar.showsHorizontalScrollIndicator = NO;
    [self addSubview:_navgationTabBar];
    

    
    _hSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, NAV_TAB_BAR_HEIGHT-1, SCREEN_WIDTH, 1)];
    _hSeparatorLine.backgroundColor = [UIColor grayColor];;
    [self addSubview:_hSeparatorLine];
}

- (void)showLineWithButtonWidth:(CGFloat)width
{
    if (!_line)
    {
        _line = [[UIView alloc] initWithFrame:CGRectMake(2.0f, NAV_TAB_BAR_HEIGHT - 3.0f, width - 4.0f, 3.0f)];
        _line.backgroundColor = self.lineColor ? self.lineColor : UIColorWithRGBA(20.0f, 80.0f, 200.0f, 0.7f);
        [_navgationTabBar addSubview:_line];
    }
}

- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    CGFloat buttonX = DOT_COORDINATE;
    for (NSInteger index = 0; index < [_itemTitles count]; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, DOT_COORDINATE, [widths[index] floatValue], NAV_TAB_BAR_HEIGHT);
        [button setTitle:_itemTitles[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_navgationTabBar addSubview:button];
        
        [_items addObject:button];
        buttonX += [widths[index] floatValue];
    }
    
    // 这边有个问题，刚开始都是默认从0开始选中。。。。待优化  xianminxiao   2017／3/16
    [self showLineWithButtonWidth:[widths[0] floatValue]];
    return buttonX;
}

- (void)itemPressed:(UIButton *)button
{
    NSInteger index = [_items indexOfObject:button];
    if (_delegate && [_delegate respondsToSelector:@selector(itemDidSelectedWithIndex:)])
    {
        [_delegate itemDidSelectedWithIndex:index];
    }
}

- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles;
{
    NSMutableArray *widths = [@[] mutableCopy];
    
    for (NSString *title in titles)
    {
        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
        NSNumber *width = [NSNumber numberWithFloat:size.width + BUTTON_ITEM_PADDING_WIDTH];
        [widths addObject:width];
    }
    
    return widths;
}

@end
