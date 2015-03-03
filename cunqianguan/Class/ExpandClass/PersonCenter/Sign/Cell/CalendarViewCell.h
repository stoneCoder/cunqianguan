//
//  CalendarViewCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/3.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignModel.h"
@interface CalendarViewCell : UICollectionViewCell
-(void)loadCell:(SignModel *)model;
@end
