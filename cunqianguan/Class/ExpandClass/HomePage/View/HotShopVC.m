//
//  HotShopVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/5.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HotShopVC.h"
#import "HotShopCell.h"
#import "HotDetailShopVC.h"

#import "Constants.h"
#import "PersonInfo.h"
#import "HomeConnect.h"
#import "BaseConnect.h"

#import "HotShopListModel.h"
@interface HotShopVC ()
{
    NSInteger _pageNum;
    PersonInfo *_info;
    NSMutableArray *_data;
}

@end
static NSString *hotShopCellID = @"HotShopCell";
@implementation HotShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    _data = [NSMutableArray array];
    [self initLocalData];
    [self setUpCollection];
    [self showLoaderView];
    [self loadData];
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
    UINib *cellNib=[UINib nibWithNibName:@"HotShopCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:hotShopCellID];
}

-(void)initLocalData
{
    HotShopModel *tmall = [[HotShopModel alloc] init];
    tmall.mallName = @"天猫商城";
    tmall.fanli = @"55%";
    tmall.logo = @"tmall_shop";
    tmall.fanliUrl = [NSString stringWithFormat:@"%@%@&unid=%@",MALL_TB_URL1,MM,_info.userId];
    [_data addObject:tmall];
    
    HotShopModel *dayBuy = [[HotShopModel alloc] init];
    dayBuy.mallName = @"天天特价";
    dayBuy.fanli = @"55%";
    dayBuy.logo = @"day_shop";
    dayBuy.fanliUrl = [NSString stringWithFormat:@"%@%@&unid=%@",MALL_TB_URL2,MM,_info.userId];
    [_data addObject:dayBuy];
    
    HotShopModel *taobao = [[HotShopModel alloc] init];
    taobao.mallName = @"淘宝旅行";
    taobao.fanli = @"55%";
    taobao.logo = @"ali_travel";
    taobao.fanliUrl = [NSString stringWithFormat:@"%@%@&unid=%@",MALL_TB_URL3,MM,_info.userId];
    [_data addObject:taobao];
}

-(void)loadData
{
    [[HomeConnect sharedHomeConnect] gethotmalllist:_info.userId success:^(id json) {
        [self hideLoaderView];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            HotShopListModel *listModel = [[HotShopListModel alloc] initWithDictionary:dic error:nil];
            [_data addObjectsFromArray:listModel.data];
            [self.collectionView reloadData];
        }
    } failure:^(NSError *err) {
        [self hideLoaderView];
    }];
}
#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((VIEW_WIDTH - 20)/3, (VIEW_WIDTH - 20)/3);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:hotShopCellID forIndexPath:indexPath];
    [cell loadCell:_data[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotShopModel *model = _data[indexPath.row];
    NSString *urlPath = model.fanliUrl;
    if (indexPath.row > 2) {
        urlPath = [NSString stringWithFormat:@"%@",urlPath];
    }
    HotDetailShopVC *hotDetailShopVC = [[HotDetailShopVC alloc] init];
    hotDetailShopVC.leftTitle = model.mallName;
    hotDetailShopVC.urlPath = urlPath;
    [self.navigationController pushViewController:hotDetailShopVC animated:YES];
}

@end
