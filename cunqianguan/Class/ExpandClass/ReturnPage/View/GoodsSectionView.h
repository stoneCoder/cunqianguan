//
//  GoodsSectionView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/22.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridMenu.h"
@class MenuCell;
@protocol GoodsSectionViewDelagate<NSObject>
-(void)tapItemWithCell:(MenuCell *)cell;
@end

@interface GoodsSectionView : UICollectionReusableView<GridMenuDeleage>
@property (strong,nonatomic) MenuCell *selectCell;
@property (strong,nonatomic) id<GoodsSectionViewDelagate> delegate;
@end
