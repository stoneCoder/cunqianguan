//
//  FavoriteView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "FavoriteView.h"
#import "FavoriteCell.h"

static NSString *collectionCellID = @"FavoriteCell";
@implementation FavoriteView
{
    NSArray *_dataArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setUpFavoriteData:(NSArray *)array
{
    _dataArray = array;
    UINib *cellNib=[UINib nibWithNibName:@"FavoriteCell" bundle:nil];
    [self registerNib:cellNib forCellWithReuseIdentifier:collectionCellID];
    [self reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.frame.size.width - 20)/3, 120);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FavoriteCell *cell = (FavoriteCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xececec);
}
@end
