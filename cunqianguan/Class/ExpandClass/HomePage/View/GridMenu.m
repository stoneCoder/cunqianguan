//
//  GridMenu.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/20.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "GridMenu.h"
#import "MenuCell.h"
#import "LoginVC.h"
#import "BaseNC.h"
#import "GoodsViewVC.h"

static NSString *  collectionCellID=@"MenuCell";
@implementation GridMenu
{
    NSArray *_menuNameArray;
    NSArray *_menuImageArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setUpMenuData:(NSDictionary *)dictionary
{
    _menuImageArray = [dictionary objectForKey:@"gridImage"];
    _menuNameArray = [dictionary objectForKey:@"gridName"];
    UINib *cellNib=[UINib nibWithNibName:@"MenuCell" bundle:nil];
    [self registerNib:cellNib forCellWithReuseIdentifier:collectionCellID];
    [self reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return _menuNameArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width/4, self.frame.size.height/2);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.menuLabel.text = _menuNameArray[indexPath.row];
    cell.menuImage.image = [UIImage imageNamed:_menuImageArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = (MenuCell *)[collectionView cellForItemAtIndexPath:indexPath];
     cell.backgroundColor = UIColorFromRGB(0xececec);
    if (self.gridMenuDelegate && [self.gridMenuDelegate respondsToSelector:@selector(selectItem:)]) {
        [self.gridMenuDelegate selectItem:cell];
    }
}
@end
