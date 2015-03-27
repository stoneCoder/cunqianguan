//
//  PolyTomorrowVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyTomorrowVC.h"
#import "GoodsCell.h"
#import "PolyGoodsRootVC.h"
#import "PolyGoodsCell.h"

#import "PersonInfo.h"
#import "JYHConnect.h"
#import "BaseConnect.h"
#import "JYHListModel.h"



static NSString *collectionCellID = @"PolyGoodsCell";
@interface PolyTomorrowVC ()
{
    NSMutableArray *_data;
    JYHListModel *_listModel;
    NSInteger _category;
    NSInteger _pageNum;
}

@end

@implementation PolyTomorrowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _data = [NSMutableArray array];
    _category = 0;
    _pageNum = 1;
    [self setUpCollection];
    [self showLoaderView:self.collectionView];
    [self loadDataWith:_category andPage:_pageNum];
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
-(void)setUpCollection
{
    self.collectionView.backgroundColor = UIColorFromRGB(0xECECEC);
    UINib *cellNib=[UINib nibWithNibName:@"PolyGoodsCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:collectionCellID];
    
    [self setRefreshEnabled:YES];
}

-(void)loadDataWith:(NSInteger)category andPage:(NSInteger)page
{
    PersonInfo *person = [PersonInfo sharedPersonInfo];
    [[JYHConnect sharedJYHConnect] getJyhGoodsTomorrowById:person.userId withCategory:category andPage:page success:^(id json) {
        [self hideLoaderView];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _listModel = [[JYHListModel alloc] initWithDictionary:dic error:nil];
            if (page == 1) {
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:_listModel.data];
            if (_data.count == 0) {
                self.defaultEmptyView.hidden = NO;
                self.defaultEmptyView.emptyInfoLabel.text = @"每日下午4点更新";
                self.collectionView.hidden = YES;
            }
            [self.collectionView reloadData];
        }
    } failure:^(NSError *err) {
        [self hideLoaderView];
    }];
}

-(void)refresh
{
    [self loadDataWith:0 andPage:1];
    [super refresh];
}

-(void)moreFresh
{
    _pageNum ++;
    [self loadDataWith:_category andPage:_pageNum];
    [super moreFresh];
}


#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/2 - 10, 220);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PolyGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    [cell loadCell:_data[indexPath.row] withType:1];
    cell.tag = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PolyGoodsRootVC *polyGoodsRootVC = [[PolyGoodsRootVC alloc] init];
    JYHModel *model = _data[indexPath.row];
    NSString *goodKey = [NSString stringWithFormat:@"1000_%@",model.productId];
    polyGoodsRootVC.goodKey = goodKey;
    polyGoodsRootVC.leftTitle = @"商品详情";
    [self.navigationController pushViewController:polyGoodsRootVC animated:YES];

}
@end
