//
//  CollectVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "CollectVC.h"
#import "CollectCell.h"

@interface CollectVC ()

@end
static NSString *collectID = @"CollectCell";
@implementation CollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpCollection];
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

#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/2 - 10, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}
@end
