//
//  BaseTableVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//


#import "BaseTableVC.h"
#import "UIScrollView+MJRefresh.h"

@interface BaseTableVC ()

@property(nonatomic, assign) CGSize visibleSize;

@end

@implementation BaseTableVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)createTableWithStye:(UITableViewStyle)style
{
    if (self.tableView == nil) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, [UIScreen mainScreen].bounds.size.height);
        self.tableView = [[UITableView alloc] initWithFrame:frame style:style];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = UIColorFromRGB(0xececec);
        [self.view addSubview:self.tableView];
    }
    if (iOS7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

-(void)setRefreshEnabled:(BOOL)enabled
{
    if (enabled) {
        [self.tableView addHeaderWithTarget:self action:@selector(refresh)];
        [self.tableView addFooterWithTarget:self action:@selector(moreFresh)];
    }
}

-(void)refresh
{
    [self.tableView performSelector:@selector(headerEndRefreshing) withObject:nil afterDelay:2];
}

-(void)moreFresh
{
    [self.tableView performSelector:@selector(footerEndRefreshing) withObject:nil afterDelay:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{return 0;};
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
@end


@implementation UITableView (RLBaseTableVC)

-(void)scrollToBottom{
    [self scrollToBottom:YES withVisibleHeight:0];
}

-(void)scrollToBottomWithVisibleHeight:(CGFloat)visibleHeight{
    [self scrollToBottom:YES withVisibleHeight:visibleHeight];
}

-(void)scrollToBottomWithoutAnimation{
    [self scrollToBottom:NO withVisibleHeight:0];
}

-(void)scrollToBottomWithVisibleHeightButAnimation:(CGFloat)visibleHeight{
    [self scrollToBottom:NO withVisibleHeight:visibleHeight];
}

-(void)scrollToBottom:(BOOL)animation withVisibleHeight:(CGFloat)visibleHeight{
    if (visibleHeight == 0) {
        visibleHeight = self.frame.size.height;
    }
    if (self.contentSize.height > visibleHeight)
    {
        CGPoint offset = CGPointMake(0, self.contentSize.height - visibleHeight);
        [self setContentOffset:offset animated:animation];
    }
}
@end
