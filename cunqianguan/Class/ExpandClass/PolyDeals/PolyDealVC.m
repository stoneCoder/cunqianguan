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

#import "BaseSelectView.h"
#import "PolyGoodsRootVC.h"

@interface PolyDealVC ()
{
    NSMutableArray *_data;
}

@end
static NSString *  collectionCellID=@"PolyGoodsCell";
@implementation PolyDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self setUpNavBtn];
    _data = [NSMutableArray array];
    [self setUpCollection];
}

-(void)viewDidCurrentView
{
    if ([self.leftTitle isEqualToString:@"全部"]) {
        for (int i = 0; i < 20; i++) {
            [_data addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }else{
        for (int i = 0; i < 5; i++) {
            [_data addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)setUpNavBtn
{
    UIButton *rigthButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search"] forState:UIControlStateNormal];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search_hover"] forState:UIControlStateHighlighted];
    //[rigthButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rigthButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}

-(void)setUpCollection
{
    self.collectionView.backgroundColor = UIColorFromRGB(0xECECEC);
    //[self.collectionView setFrame:CGRectMake(0, 0, VIEW_WIDTH, self.collectionView.frame.size.height)];
    UINib *cellNib = [UINib nibWithNibName:@"PolyGoodsCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:collectionCellID];
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
#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_data count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/2 - 10, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PolyGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PolyGoodsRootVC *polyGoodsRootVC = [[PolyGoodsRootVC alloc] init];
    polyGoodsRootVC.leftTitle = @"商品详情";
    [self.navigationController pushViewController:polyGoodsRootVC animated:YES];
}

@end
