//
//  FavoriteView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseCollectionView.h"

@interface FavoriteView : BaseCollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
-(void)setUpFavoriteData:(NSArray *)array;

@end