//
//  CalendarView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/3.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseCollectionView.h"

@interface CalendarView : BaseCollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
-(void)reloadDataWith:(NSArray *)data andNowDate:(NSDate *)date;
@end
