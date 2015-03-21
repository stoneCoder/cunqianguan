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
@interface PolyDealVC ()
{
    NSMutableArray *_data;
    JYHListModel *_listModel;
    NSInteger _pageNum;
    NSInteger _category;
    PersonInfo *_info;
    BOOL _firstLoad;
}

@end
static NSString *  collectionCellID=@"PolyGoodsCell";
@implementation PolyDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    _data = [NSMutableArray array];
    _pageNum = 1;
    _category = 0;
    [self setUpCollection];
}

-(void)viewDidCurrentView:(NSInteger)index
{
    [_data removeAllObjects];
    _category = index;
    if (!_firstLoad) {
        [self showLoaderView:self.collectionView];
    }
    [self loadDataWith:_category andPage:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)setUpCollection
{
    self.collectionView.backgroundColor = UIColorFromRGB(0xECECEC);
    UINib *cellNib = [UINib nibWithNibName:@"PolyGoodsCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:collectionCellID];
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
    return CGSizeMake(VIEW_WIDTH/2 - 15, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PolyGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    [cell loadCell:_data[indexPath.row] withType:0];
    cell.tag = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_info isLoginWithPresent:^(BOOL flag) {
        PolyGoodsRootVC *polyGoodsRootVC = [[PolyGoodsRootVC alloc] init];
        JYHModel *model = _data[indexPath.row];
        NSString *goodKey = [NSString stringWithFormat:@"1000_%@",model.productId];
        polyGoodsRootVC.goodKey = goodKey;
        polyGoodsRootVC.leftTitle = @"商品详情";
        [self.navigationController pushViewController:polyGoodsRootVC animated:YES];
    } WithType:YES];
    
}
@end
