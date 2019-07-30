//
//  TableDataViewController.m
//  NavTabBarViewControllerDemo
//
//  Created by xianminxiao on 17/3/18.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "TableDataViewController.h"
#import "NavTabBarItemTableView.h"
#import "NavTabBarItemTableViewCell.h"

@interface TableDataViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSString*                _title;
    NavTabBarItemTableView*  _tableView;
}

@end

@implementation TableDataViewController

- (id)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self)
    {
        _title = title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)viewControllerContentOffsetY
{
    return [_tableView tableViewContentOffsetY];
}

- (void)disableScrollListToTop:(BOOL)disable
{
    _tableView.scrollsToTop = disable;
}

#pragma mark -- talbeView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL nibsRegistered=NO;
    if (!nibsRegistered) {
        UINib *nib=[UINib nibWithNibName:@"NavTabBarItemTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"NavTabBarItemTableViewCell"];
        nibsRegistered=YES;
    }
    
    
    NavTabBarItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NavTabBarItemTableViewCell"];
    NSString *tempStr = [NSString stringWithFormat:@"我是%@第%ld条数据。", _title, (long)indexPath.row];
    cell.tipTitle.text = tempStr;
    
    return cell;
}

#pragma mark - Private Methods
#pragma mark -
- (void)initTableView
{
    // Iinitialize value
    _tableView = [[NavTabBarItemTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.dataSource = self;
    _tableView.bounces = NO;

    
    [self.view addSubview:_tableView];
    
    [self disableScrollListToTop:NO];
}


- (void)setSubVCTableViewDelegate:(id<NavTabBarItemTableViewDelegate>)tableViewDelegate
{
    _tableView.itemTableViewDelegate = tableViewDelegate;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
