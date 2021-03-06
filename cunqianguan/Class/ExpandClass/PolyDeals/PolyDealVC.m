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

#import "PolyGoodsRootVC.h"

#import "BaseConnect.h"
#import "JYHConnect.h"
#import "PersonInfo.h"

#import "JYHListModel.h"
#import "JYHModel.h"

#import "UICollectionViewCell+AutoLayoutDynamicHeightCalculation.h"
#import "BMAlert.h"
@interface PolyDealVC ()
{
    NSMutableArray *_data;
    JYHListModel *_listModel;
    NSInteger _pageNum;
    NSInteger _category;
    PersonInfo *_info;
    BOOL _firstLoad;
    NSMutableDictionary *_polyGoodsCells;
}
@end
static NSString *  polyCollectionCellID=@"PolyGoodsCell";
@implementation PolyDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    _data = [NSMutableArray array];
    _pageNum = 1;
    _category = 0;
    _polyGoodsCells = [NSMutableDictionary dictionary];
    [self setUpCollection];
}

-(void)viewDidCurrentView:(NSInteger)index
{
    //[_data removeAllObjects];
    _category = index;
    if (!_firstLoad) {
        [self showLoaderView:self.collectionView];
        [self loadDataWith:_category andPage:1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)setUpCollection
{
    self.collectionView.backgroundColor = UIColorFromRGB(0xECECEC);
    UINib *cellNib = [UINib nibWithNibName:@"PolyGoodsCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:polyCollectionCellID];
    [self setRefreshEnabled:YES];
}

-(void)loadDataWith:(NSInteger)category andPage:(NSInteger)page
{
    [[JYHConnect sharedJYHConnect] getJYHGoodsById:_info.userId withCategory:category andPage:page success:^(id json) {
        [self hideLoaderView];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _listModel = [[JYHListModel alloc] initWithDictionary:dic error:nil];
            if (page == 1) {
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:_listModel.data];
            _firstLoad = YES;
            [self.collectionView reloadData];
        }
    } failure:^(NSError *err) {
        [self hideLoaderView];
    }];
}

-(void)refresh
{
    [self loadDataWith:_category andPage:1];
    [super refresh];
}

-(void)moreFresh
{
    _pageNum ++;
    [self loadDataWith:_category andPage:_pageNum];
    [super moreFresh];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_data count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (SCREEN_WIDTH - 30)/2;
    PolyGoodsCell *cell = [PolyGoodsCell heightCalculationCellFromNibWithName:NSStringFromClass([PolyGoodsCell class])];
    CGFloat height = [cell heightAfterAutoLayoutPassAndRenderingWithBlock:^{
        if (_data.count > 0) {
            [cell loadCell:_data[indexPath.row] withType:0];
        }
    } collectionViewWidth:width];
    return CGSizeMake(width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PolyGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:polyCollectionCellID forIndexPath:indexPath];
    if (_data.count > 0) {
         [cell loadCell:_data[indexPath.row] withType:0];
    }
    [cell layoutIfNeeded];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_info isLoginWithPresent:^(BOOL flag) {
        JYHModel *model = _data[indexPath.row];
        NSString *goodKey = [NSString stringWithFormat:@"1000_%@",model.productId];
        /*没有登陆*/
        if (!flag) {
            [[BMAlert sharedBMAlert] alert:@"登陆去购物才有返利拿哦" cancleTitle:@"登陆" otherTitle:@"跳过" cancle:^(DoAlertView *alertView) {
                [_info presentNav:self WithCompletion:nil];
            } other:^(DoAlertView *alertView) {
                [self pushToDetail:goodKey];
            }];
        }else{
            /*登陆*/
            [self pushToDetail:goodKey];
        }
    } WithType:NO];
}

-(void)pushToDetail:(NSString *)goodKey
{
    PolyGoodsRootVC *polyGoodsRootVC = [[PolyGoodsRootVC alloc] init];
    polyGoodsRootVC.goodKey = goodKey;
    polyGoodsRootVC.leftTitle = @"商品详情";
    [self.navigationController pushViewController:polyGoodsRootVC animated:YES];
}
@end
