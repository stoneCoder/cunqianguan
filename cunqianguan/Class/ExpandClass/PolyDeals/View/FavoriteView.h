//
//  FavoriteView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseCollectionView.h"
@class JYHItemModel;
@protocol FavoriteViewDelegate<NSObject>
-(void)clickItemCell:(JYHItemModel *)model;
@end
@interface FavoriteView : BaseCollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) id<FavoriteViewDelegate> favoriteViewDelegate;
-(void)setUpFavoriteData:(NSArray *)array;

@end
