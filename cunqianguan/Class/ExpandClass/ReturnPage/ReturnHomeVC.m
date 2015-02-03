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

static NSString *  collectionCellID=@"GoodsCell";
static NSString *  collectionHeadID=@"GoodsSectionView";
@interface ReturnHomeVC ()<UICollectionViewDataSource,UICollectionViewDelegate,GoodsSectionViewDelagate>

@end

@implementation ReturnHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpCollection];
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
    return 16;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/2 - 10, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    GoodsSectionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                   UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeadID forIndexPath:indexPath];
    headerView.delegate = self;
    
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReturnHomeGoodsVC *returnHomeGoodsVC = [[ReturnHomeGoodsVC alloc] init];
    returnHomeGoodsVC.leftTitle = @"商品详情";
    [self.navigationController pushViewController:returnHomeGoodsVC animated:YES];
}

#pragma mark - 
-(void)tapItemWithCell:(MenuCell *)cell
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 5, 5, 5)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10.0;
        
    GoodsViewVC *goodsViewVC = [[GoodsViewVC alloc] initWithCollectionViewLayout:flowLayout];
    goodsViewVC.leftTitle = cell.menuLabel.text;
    [self.navigationController pushViewController:goodsViewVC animated:YES];
}

@end
