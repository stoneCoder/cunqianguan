//
//  HotShopVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/5.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HotShopVC.h"
#import "HotShopCell.h"

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
    [self setUpCollection];
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

-(void)loadData
{
    [self showHUD:DATA_LOAD];
    [[HomeConnect sharedHomeConnect] gethotmalllist:_info.userId success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            HotShopListModel *listModel = [[HotShopListModel alloc] initWithDictionary:dic error:nil];
            [_data addObjectsFromArray:listModel.data];
            [self.collectionView reloadData];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
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
    
}

@end
