//
//  MyOrderScrollVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/13.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MyOrderScrollVC.h"
#import "BaseSegment.h"
#import "MyOrderVC.h"
@interface MyOrderScrollVC ()<CCSegmentDelegate,UIScrollViewDelegate>
{
    NSArray *_titleArray;
    BaseSegment *_segment;
    UIScrollView *_scrollView;
    NSInteger _currentIndex;
}
@end

@implementation MyOrderScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArray = @[@"淘宝订单",@"商城订单"];
    [self setUpSegment];
    [self setupScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)setUpSegment
{
    _segment = [[BaseSegment alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    _segment.backgroundColor = [UIColor whiteColor];
    _segment.delegate = self;
    [_segment setItems:_titleArray isShowLine:NO WithSelectPlace:ShowSelectPlaceFromBottom];
    [self.view addSubview:_segment];
}

-(void)setupScrollView
{
    CGFloat visiableY = _segment.frame.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, visiableY, VIEW_WIDTH, SCREEN_HEIGTH - visiableY - 64)];
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(VIEW_WIDTH *[_titleArray count], SCREEN_HEIGTH - visiableY - 64)];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < _titleArray.count; i++) {
        MyOrderVC *myOrderVC = [[MyOrderVC alloc] init];
        [self addChildViewController:myOrderVC];
        myOrderVC.view.frame = CGRectMake(i*VIEW_WIDTH, 0, VIEW_WIDTH, _scrollView.frame.size.height);
        [_scrollView addSubview:myOrderVC.view];
    }
    [[self childViewControllers][0] viewDidCurrentView:0];
}

#pragma mark -- CCSegmentDelegate
-(void)selectIndex:(NSInteger)index
{
    if (_currentIndex == index) {
        return;
    }
    [_scrollView scrollRectToVisible:CGRectMake(index*VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT) animated:YES];
    
    _currentIndex = index;
    [[self childViewControllers][index] viewDidCurrentView:index];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/VIEW_WIDTH;
    [_segment setSelectIndex:index];
    [self selectIndex:index];
}
@end
