//
//  GoodsSectionView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/22.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "GoodsSectionView.h"

@implementation GoodsSectionView
{
    GridMenu *_gridMenu;
}

- (void)awakeFromNib {
    // Initialization code
    [self setUpGridMenu];
    [self addSubview:_gridMenu];
}

#pragma mark -- Private
-(void)setUpGridMenu
{
    NSArray *menuNameArray = @[@"全部",@"时尚女装",@"流行男装",@"母婴玩具",@"数码家电",@"家居家纺",@"美容护肤",@"美食茗茶"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < menuNameArray.count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"lanmu%d",i+1];
        [array addObject:imageName];
    }
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    _gridMenu = [[GridMenu alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) collectionViewLayout:flowLayout];
    _gridMenu.backgroundColor = [UIColor whiteColor];
    _gridMenu.dataSource = _gridMenu;
    _gridMenu.delegate = _gridMenu;
    _gridMenu.gridMenuDelegate = self;
    [_gridMenu setUpMenuData:@{@"gridName":menuNameArray,@"gridImage":array}];
}

-(void)selectItem:(MenuCell *)cell
{
    _selectCell = cell;
    if (_delegate && [_delegate respondsToSelector:@selector(tapItemWithCell:)]) {
        [_delegate tapItemWithCell:cell];
    }
}
@end
