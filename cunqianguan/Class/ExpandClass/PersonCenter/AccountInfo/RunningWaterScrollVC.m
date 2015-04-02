//
//  RunningWaterScrollVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/2.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "RunningWaterScrollVC.h"
#import "BaseSegment.h"
#import "RunningWaterVC.h"
@interface RunningWaterScrollVC ()<CCSegmentDelegate,UIScrollViewDelegate>
{
    NSArray *_titleArray;
    BaseSegment *_segment;
    UIScrollView *_scrollView;
    NSInteger _currentIndex;
}

@end

@implementation RunningWaterScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArray = @[@"收入",@"提现",@"待返利",@"兑换"];
    [self setUpSegment];
    [self setupScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpSegment
{
    _segment = [[BaseSegment alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    _segment.backgroundColor = [UIColor whiteColor];
    _segment.layer.borderWidth = 1.0f;
    _segment.layer.borderColor = UIColorFromRGB(0xE3E3E5).CGColor;
    _segment.delegate = self;
    [_segment setItems:_titleArray isShowLine:YES WithSelectPlace:ShowSelectPlaceFromBottom];
    [self.view addSubview:_segment];
}

-(void)setupScrollView
{
    CGFloat visiableY = _segment.frame.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, visiableY, VIEW_WIDTH, VIEW_HEIGHT - visiableY - 64)];
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(VIEW_WIDTH *[_titleArray count], VIEW_HEIGHT - visiableY - 64)];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < _titleArray.count; i++) {
        RunningWaterVC *runningWaterVC = [[RunningWaterVC alloc] init];
        [self addChildViewController:runningWaterVC];
        runningWaterVC.view.frame = CGRectMake(i*VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT - visiableY - 64);
        [_scrollView addSubview:runningWaterVC.view];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
