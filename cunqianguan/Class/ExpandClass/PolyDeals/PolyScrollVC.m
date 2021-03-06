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
#import "UIView+Borders.h"

#import "PolyDealTableVC.h"
#import "DynamicBtnScrollView.h"
#import "BaseUtil.h"
@interface PolyScrollVC ()<DynamicBtnScrollViewDelegate,BaseSelectViewDelegate,UIScrollViewDelegate>
{
    //TouchPropagatedScrollView *_navScrollV;
    DynamicBtnScrollView *_navScrollV;
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
    _btnArray = TABLE_MENU_ARRAY;
    _btnIdArray = TABLE_MENU_ID;
    //[self setUpRightBtn];
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
    [selectBtn addBottomBorderWithHeight:0.5f andColor:UIColorFromRGB(0xe6e6e6)];
    [selectBtn setImage:[UIImage imageNamed:@"zhankai"] forState:UIControlStateNormal];
    [selectBtn setBackgroundColor:[UIColor whiteColor]];
    [selectBtn addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
    
    
//    _navScrollV = [[TouchPropagatedScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - btnW, 44)];
//    _navScrollV.segmentDelegate = self;
//    _navScrollV.backgroundColor = [UIColor whiteColor];
//    [_navScrollV setShowsHorizontalScrollIndicator:NO];
//    
//    [_navScrollV setContentSize:CGSizeMake(btnW * [_btnArray count], btnH)];
//    [_navScrollV setItems:_btnArray isShowLine:YES];
    
    _navScrollV = [[DynamicBtnScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - btnW, 44)];
    [_navScrollV addBottomBorderWithHeight:0.5f andColor:UIColorFromRGB(0xe6e6e6)];
    _navScrollV.dynamicDelegate = self;
    _navScrollV.backgroundColor = [UIColor whiteColor];
    [_navScrollV setShowsHorizontalScrollIndicator:NO];
    
    NSDictionary *dic = [self calculateWidth:_btnArray andHeight:btnH];
    [_navScrollV setContentSize:CGSizeMake([[dic objectForKey:@"totalWidth"] integerValue], btnH)];
    [_navScrollV setItems:_btnArray withItemWidth:[dic objectForKey:@"widthArray"] isShowSeparatorLine:YES];

    [self.view addSubview:_navScrollV];
}

#pragma mark -- Private 计算按钮宽度
-(NSDictionary *)calculateWidth:(NSArray *)titleArray andHeight:(CGFloat)height
{
    CGFloat totalWidth = 0;
    NSMutableArray *widthArray = [NSMutableArray array];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    for (int i = 0; i < titleArray.count; i++) {
        CGFloat width = [BaseUtil getWidthByString:titleArray[i] font:btn.titleLabel.font allheight:height andMaxWidth:100] + 20;
        [widthArray addObject:[NSNumber numberWithFloat:width]];
        totalWidth += width;
    }
    return @{@"widthArray":widthArray,@"totalWidth":@(totalWidth)};
}

-(void)setupScrollView
{
    CGFloat visiableY = _navScrollV.frame.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, visiableY, VIEW_WIDTH, SCREEN_HEIGTH - visiableY - 64)];
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(VIEW_WIDTH *[_btnArray count], SCREEN_HEIGTH - visiableY - 64)];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < _btnArray.count; i++) {
//        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
//        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 0, 10)];
//        flowLayout.minimumInteritemSpacing = 0;
//        flowLayout.minimumLineSpacing = 10.0;
//        
//        PolyDealVC *polyDealVC = [[PolyDealVC alloc] initWithCollectionViewLayout:flowLayout];
//        polyDealVC.leftTitle = _btnArray[i];
//        [self addChildViewController:polyDealVC];
//        polyDealVC.view.frame = CGRectMake(i*VIEW_WIDTH, 0, VIEW_WIDTH, _scrollView.frame.size.height);
//        [_scrollView addSubview:polyDealVC.view];
        PolyDealTableVC *polyDealVC = [[PolyDealTableVC alloc] init];
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
    [_selectView initView:_btnArray andVisiableY:_navScrollV.frame.size.height + _navScrollV.frame.origin.y+ 64];
    _selectView.delegate = self;
    [_selectView setSelectIndex:_currentIndex];
    [_selectView setHidden:YES];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_selectView];
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
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 0, 10)];
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

#pragma mark -- DynamicBtnScrollViewDelegate
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

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/VIEW_WIDTH;
    [_navScrollV setSelectIndex:index];
    [self selectIndex:index];
}
@end
