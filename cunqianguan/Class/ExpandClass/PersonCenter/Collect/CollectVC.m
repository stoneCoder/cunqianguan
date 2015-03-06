//
//  CollectVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "CollectVC.h"
#import "CollectCell.h"

#import "PersonConnect.h"
#import "BaseConnect.h"
#import "PersonInfo.h"
#import "CollectListModel.h"
@interface CollectVC ()
{
    NSInteger _pageNum;
    NSMutableArray *_data;
    PersonInfo *_info;
}

@end
static NSString *collectID = @"CollectCell";
@implementation CollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _pageNum = 1;
    _data = [NSMutableArray array];
    _info = [PersonInfo sharedPersonInfo];
    [self setUpCollection];
    [self loadData:_pageNum];
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
    UINib *cellNib = [UINib nibWithNibName:@"CollectCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:collectID];
    [self setRefreshEnabled:YES];
}

-(void)loadData:(NSInteger)page
{
    [self showHUD:DATA_LOAD];
    [[PersonConnect sharedPersonConnect] getUserFavorite:_info.email pwd:_info.password page:page success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            CollectListModel *listModel = [[CollectListModel alloc] initWithDictionary:dic error:nil];
            if (page == 1) {
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:listModel.data];
            [self.collectionView reloadData];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

-(void)refresh
{
    [self loadData:1];
    [super refresh];
}

-(void)moreFresh
{
    _pageNum ++;
    [self loadData:_pageNum];
    [super moreFresh];
}

#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/2 - 10, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    [cell loadCell:_data[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}
@end
