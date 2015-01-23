//
//  PolyDealVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/23.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyDealVC.h"
#import "PolyGoodsCell.h"
#import "TouchPropagatedScrollView.h"
#import "BaseSegment.h"

@interface PolyDealVC ()<SegmentDelegate>
{
    UIView *_selectTabV;
    TouchPropagatedScrollView *_navScrollV;
}

@end
static NSString *  collectionCellID=@"PolyGoodsCell";
@implementation PolyDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleText:@"聚优惠"];
    [self setNavBtn];
    [self setUpSliderView];
    [self setUpSelectView];
    [self setUpCollection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)setNavBtn
{
    UIButton *rigthButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search"] forState:UIControlStateNormal];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search_hover"] forState:UIControlStateHighlighted];
    //[rigthButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rigthButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}

-(void)setUpSliderView
{
    CGFloat btnW = self.view.frame.size.width/5;
    CGFloat btnH = 44.0f;
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setFrame:CGRectMake(self.view.frame.size.width - btnW, 0, btnW, btnH)];
    [selectBtn setBackgroundColor:[UIColor redColor]];
    [selectBtn setTitle:@"+" forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
    
    
    _navScrollV = [[TouchPropagatedScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - btnW, 44)];
    _navScrollV.segmentDelegate = self;
    _navScrollV.backgroundColor = [UIColor whiteColor];
    [_navScrollV setShowsHorizontalScrollIndicator:NO];
    NSArray *arT = @[@"测试1", @"测试2", @"测试3", @"测试4", @"测试5", @"测试6", @"测试7", @"测试8", @"测试9", @"测试10"];
    [_navScrollV setContentSize:CGSizeMake(btnW * [arT count], btnH)];
    [_navScrollV setItems:arT isShowLine:YES];
    
    [self.view insertSubview:_navScrollV aboveSubview:self.collectionView];
}

-(void)setUpCollection
{
    CGFloat visiableY = _navScrollV.frame.size.height;
    self.collectionView.backgroundColor = UIColorFromRGB(0xECECEC);
    [self.collectionView setFrame:CGRectMake(0, visiableY, VIEW_WIDTH, self.collectionView.frame.size.height - visiableY)];
    UINib *cellNib = [UINib nibWithNibName:@"PolyGoodsCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:collectionCellID];
    [self setRefreshEnabled:YES];
}

-(void)setUpSelectView
{
    _selectTabV = [[UIView alloc] initWithFrame:CGRectMake(0, _navScrollV.frame.size.height, self.collectionView.frame.size.width, self.collectionView.frame.size.height)];
    //[_selectTabV setFrame:CGRectMake(0, 0, self.view.frame.size.width, _navScrollV.frame.size.height)];
    _selectTabV.backgroundColor = [UIColor whiteColor];
    [_selectTabV setHidden:YES];
    [self.view insertSubview:_selectTabV belowSubview:_navScrollV];
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
-(void)showSelectView:(UIButton *)btn
{
    if ([_selectTabV isHidden] == YES)
    {
        [_selectTabV setHidden:NO];
        [UIView animateWithDuration:0.6 animations:^
         {
             [_selectTabV setFrame:CGRectMake(0, _navScrollV.frame.origin.y, self.collectionView.frame.size.width, self.collectionView.frame.size.height)];
         } completion:^(BOOL finished)
         {
             
         }];
    }else
    {
        [UIView animateWithDuration:0.6 animations:^
         {
             [_selectTabV setFrame:CGRectMake(0, 0, self.view.frame.size.width, _navScrollV.frame.size.height)];
         } completion:^(BOOL finished)
         {
             [_selectTabV setHidden:YES];
         }];
    }
}

#pragma mark -- SegmentDelegate
-(void)selectIndex:(NSInteger)index
{
    CGFloat width = self.view.frame.size.width/4;
    float xx = _navScrollV.frame.size.width * (index - 1) * (width / self.view.frame.size.width) - width;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
}

-(void)actionbtn:(UIButton *)btn
{
    if(!btn.selected){
        btn.selected = YES;
    }else{
        btn.selected = NO;
    }
    
}

#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 16;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/2 - 10, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PolyGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
