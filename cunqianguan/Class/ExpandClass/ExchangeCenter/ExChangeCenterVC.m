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
#import "UICollectionViewCell+AutoLayoutDynamicHeightCalculation.h"

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
    NSInteger _type;
    NSInteger _able;
    NSInteger _category;
    BOOL _firstLoad;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    _data = [NSMutableArray array];
    _pageNum = 1;
    _able = 0;
    [self setUpCollection];
}

-(void)viewDidCurrentView:(NSInteger)index andCategroy:(NSInteger)category;
{
    _type = index;
    //[_data removeAllObjects];
    NSString *userId = _info.userId;
    if (index == 0) {
        _able = 1;
    }else{
        _able = 0;
    }
    _category = category;
    if (!_firstLoad) {
        [self showLoaderView:self.collectionView];
    }
    [self loadDataWithId:userId category:_category andPage:_pageNum];
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

-(void)loadDataWithId:(NSString *)userId category:(NSInteger)category andPage:(NSInteger)page
{
    [[ExChangeConnect sharedExChangeConnect] getExchangeList:userId WithAble:_able category:category success:^(id json) {
        [self hideLoaderView];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _listModel = [[ExChangeListModel alloc] initWithDictionary:dic error:nil];
            if (page == 1) {
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:_listModel.data];
            if (_type == 0 && _data.count == 0) {
                self.defaultEmptyView.hidden = NO;
                self.defaultEmptyView.emptyInfoLabel.text = @"没有可兑换的商品";
                self.defaultEmptyView.emptydetailInfoLabel.hidden = NO;
                self.defaultEmptyView.emptydetailInfoLabel.text = @"购物和签到均可获得积分哦";
                self.collectionView.hidden = YES;
            }
            _firstLoad = YES;
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
    CGFloat width = (SCREEN_WIDTH - 30)/2;
    ExChangeCell *cell = [ExChangeCell heightCalculationCellFromNibWithName:NSStringFromClass([ExChangeCell class])];
    CGFloat height = [cell heightAfterAutoLayoutPassAndRenderingWithBlock:^{
        if (_data.count > 0) {
            [cell loadCell:_data[indexPath.row]];
        }
    } collectionViewWidth:width];
    return CGSizeMake(width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ExChangeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    if (_data.count > 0) {
        [cell loadCell:_data[indexPath.row]];
    }
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
