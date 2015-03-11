//
//  ExChangeCenterVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/23.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ExChangeCenterVC.h"
#import "ExChangeCell.h"
#import "ChangeProductVC.h"
#import "ChangeRootVC.h"

#import "ExChangeConnect.h"
#import "BaseConnect.h"
#import "PersonInfo.h"
#import "ExChangeListModel.h"
@interface ExChangeCenterVC ()

@end
static NSString *  collectionCellID=@"ExChangeCell";
@implementation ExChangeCenterVC
{
    NSMutableArray *_data;
    ExChangeListModel *_listModel;
    NSInteger _pageNum;
    PersonInfo *_info;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _data = [NSMutableArray array];
    _pageNum = 1;
    [self setUpCollection];
}

-(void)viewDidCurrentView:(NSInteger)index;
{
    [_data removeAllObjects];
    NSString *userId = [PersonInfo sharedPersonInfo].userId;
    if (index == 0) {
        userId = @"";
    }
    [self showLoaderView:self.collectionView];
    [self loadDataWithId:userId andPage:_pageNum];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpCollection
{
    self.collectionView.backgroundColor = UIColorFromRGB(0xECECEC);
    UINib *cellNib = [UINib nibWithNibName:@"ExChangeCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:collectionCellID];
    [self setRefreshEnabled:YES];
}

-(void)loadDataWithId:(NSString *)userId andPage:(NSInteger)page
{
    [[ExChangeConnect sharedExChangeConnect] getExchangeList:userId success:^(id json) {
        [self hideLoaderView];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _listModel = [[ExChangeListModel alloc] initWithDictionary:dic error:nil];
            if (page == 1) {
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:_listModel.data];
            [self.collectionView reloadData];
        }
    } failure:^(NSError *err) {
        [self hideLoaderView];
    }];
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
    return _data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/2 - 10, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ExChangeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    [cell loadCell:_data[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeRootVC *changeRootVC = [[ChangeRootVC alloc] init];
    changeRootVC.model = _data[indexPath.row];
    changeRootVC.leftTitle = @"商品详情";
    [self.navigationController pushViewController:changeRootVC animated:YES];
}

@end
