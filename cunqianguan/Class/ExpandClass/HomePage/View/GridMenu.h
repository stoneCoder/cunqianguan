//
//  GridMenu.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/20.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseCollectionView.h"
@class MenuCell;
@protocol GridMenuDeleage <NSObject>
-(void)selectItem:(MenuCell *)cell;
@end
@interface GridMenu : BaseCollectionView
@property (strong,nonatomic) id<GridMenuDeleage> gridMenuDelegate;
-(void)setUpMenuData:(NSDictionary *)dictionary;
@end
