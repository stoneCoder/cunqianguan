//
//  TestViewController.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/4.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyScrollVC.h"
#import "TouchPropagatedScrollView.h"
#import "BaseSelectView.h"
#import "PolyDealVC.h"
#import "PolyTomorrowVC.h"
@interface PolyScrollVC ()<SegmentDelegate,BaseSelectViewDelegate,UIScrollViewDelegate>
{
    TouchPropagatedScrollView *_navScrollV;
    UIScrollView *_scrollView;
    BaseSelectView *_selectView;
    NSArray *_btnArray;
    NSArray *_btnIdArray;
    NSInteger _currentIndex;
}

@end

@implementation PolyScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _btnArray = MENU_ARRAY;
    _btnIdArray = MENU_ID;
    [self setUpRightBtn];
    [self setUpSliderView];
    [self setupScrollView];
    [self setUpSelectView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 初始化界面
- (void)setUpRightBtn
{
    [self setRigthBarWithDic:@{@"images":@[@"yushou"],@"imageshover":@[@"yushou_hover"]}];
}

-(void)setUpSliderView
{
    CGFloat btnW = self.view.frame.size.width/5;
    CGFloat btnH = 44.0f;
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setFrame:CGRectMake(self.view.frame.size.width - btnW, 0, btnW, btnH)];
    [selectBtn setImage:[UIImage imageNamed:@"zhankai"] forState:UIControlStateNormal];
    [selectBtn setBackgroundColor:[UIColor whiteColor]];
    [selectBtn addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
    
    
    _navScrollV = [[TouchPropagatedScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - btnW, 44)];
    _navScrollV.segmentDelegate = self;
    _navScrollV.backgroundColor = [UIColor whiteColor];
    [_navScrollV setShowsHorizontalScrollIndicator:NO];
    
    [_navScrollV setContentSize:CGSizeMake(btnW * [_btnArray count], btnH)];
    [_navScrollV setItems:_btnArray isShowLine:YES];
    
    [self.view addSubview:_navScrollV];
}

-(void)setupScrollView
{
    CGFloat visiableY = _navScrollV.frame.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, visiableY, VIEW_WIDTH, VIEW_HEIGHT - visiableY)];
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(VIEW_WIDTH *[_btnArray count], VIEW_HEIGHT - visiableY)];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < _btnArray.count; i++) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 0, 10)];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 10.0;
        
        PolyDealVC *polyDealVC = [[PolyDealVC alloc] initWithCollectionViewLayout:flowLayout];
        polyDealVC.leftTitle = _btnArray[i];
        [self addChildViewController:polyDealVC];
        polyDealVC.view.frame = CGRectMake(i*VIEW_WIDTH, 0, VIEW_WIDTH, _scrollView.frame.size.height);
        [_scrollView addSubview:polyDealVC.view];
    }
    [[self childViewControllers][0] viewDidCurrentView:[_btnIdArray[0] integerValue]];
}

-(void)setUpSelectView
{
    _selectView = [[BaseSelectView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    [_selectView initView:_btnArray andVisiableY:_navScrollV.frame.size.height + _navScrollV.frame.origin.y];
    _selectView.delegate = self;
    [_selectView setSelectIndex:_currentIndex];
    [_selectView setHidden:YES];
    [self.view insertSubview:_selectView aboveSubview:_scrollView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */
#pragma mark -- Private
-(void)rightBtnClick:(id)sender
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 5, 5, 5)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10.0;
    
    PolyTomorrowVC *polyTomorrowVC = [[PolyTomorrowVC alloc] initWithCollectionViewLayout:flowLayout];
    polyTomorrowVC.leftTitle = @"明日预告";
    [self.navigationController pushViewController:polyTomorrowVC animated:YES];
}

-(void)showSelectView:(UIButton *)btn
{
    if ([_selectView isHidden]){
        [_selectView showView];
    }else{
        [_selectView hideView];
    }
}

#pragma mark -- BaseSelectViewDelegate
-(void)selectBtn:(NSInteger)index
{
    [_navScrollV setSelectIndex:index];
    [self selectIndex:index];
}

#pragma mark -- SegmentDelegate
-(void)selectIndex:(NSInteger)index
{
    if (_currentIndex == index) {
        return;
    }
    CGFloat width = self.view.frame.size.width/4;
    float xx = _navScrollV.frame.size.width * (index - 1) * (width / self.view.frame.size.width) - width;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
    [_scrollView scrollRectToVisible:CGRectMake(index*VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT) animated:YES];
    
    [_selectView setSelectIndex:index];
    _currentIndex = index;
    
    [[self childViewControllers][index] viewDidCurrentView:[_btnIdArray[index] integerValue]];
}

-(void)selectTitle:(NSString *)title
{
    
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/VIEW_WIDTH;
    [_navScrollV setSelectIndex:index];
    [self selectIndex:index];
}
@end
