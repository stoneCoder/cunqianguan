//
//  ReturnHomeVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/22.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ReturnHomeVC.h"
#import "GoodsCell.h"
#import "GoodsSectionView.h"
#import "ReturnHomeGoodsVC.h"
#import "GoodsViewVC.h"
#import "MenuCell.h"

#import "PersonInfo.h"
#import "MongoConnect.h"
#import "BaseConnect.h"
#import "MongoListModel.h"

#import "BaseUtil.h"

static NSString *  collectionCellID=@"GoodsCell";
static NSString *  collectionHeadID=@"GoodsSectionView";
@interface ReturnHomeVC ()<UICollectionViewDataSource,UICollectionViewDelegate,GoodsSectionViewDelagate>
{
    GoodsSectionView *headerView;
    
    NSMutableArray *_data;
    MongoListModel *_mongoListModel;
    
    NSInteger _category;
    NSInteger _pageNum;
    
    PersonInfo *_info;
}

@end

@implementation ReturnHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    _category = 0;
    _pageNum = 1;
    _data = [NSMutableArray array];
    [self setUpCollection];
    [self showLoaderView];
    [self loadDataWith:_category andPage:_pageNum];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpCollection
{
    self.collectionView.backgroundColor = UIColorFromRGB(0xECECEC);
    UINib *cellNib=[UINib nibWithNibName:@"GoodsCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:collectionCellID];
    
    UINib *headNib=[UINib nibWithNibName:@"GoodsSectionView" bundle:nil];
    [self.collectionView registerNib:headNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeadID];
    
    [self setRefreshEnabled:YES];
}

-(void)loadDataWith:(NSInteger)category andPage:(NSInteger)page
{
    [[MongoConnect sharedMongoConnect] getMongoGoodsById:_info.userId withCategory:category andPage:page success:^(id json) {
        [self hideLoaderView];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _mongoListModel = [[MongoListModel alloc] initWithDictionary:dic error:nil];
            if (page == 1) {
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:_mongoListModel.data];
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

-(void)viewWillAppear:(BOOL)animated
{
    if(headerView.selectCell){
        headerView.selectCell.selected = NO;
    }
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


#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/2 - 15, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    [cell loadCell:_data[indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                   UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeadID forIndexPath:indexPath];
    headerView.delegate = self;
    
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_info isLoginWithPresent:^(BOOL flag) {
        ReturnHomeGoodsVC *returnHomeGoodsVC = [[ReturnHomeGoodsVC alloc] init];
        MongoModel *model = _data[indexPath.row];
        returnHomeGoodsVC.goodKey = model.goodkey;
        returnHomeGoodsVC.leftTitle = @"商品详情";
        returnHomeGoodsVC.type = 1;
        [self.navigationController pushViewController:returnHomeGoodsVC animated:YES];
    } WithType:YES];
}

#pragma mark - 
-(void)tapItemWithCell:(MenuCell *)cell
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 0, 10)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10.0;
        
    GoodsViewVC *goodsViewVC = [[GoodsViewVC alloc] initWithCollectionViewLayout:flowLayout];
    goodsViewVC.queryType = cell.tag;
    goodsViewVC.leftTitle = cell.menuLabel.text;
    [self.navigationController pushViewController:goodsViewVC animated:YES];
}

@end
