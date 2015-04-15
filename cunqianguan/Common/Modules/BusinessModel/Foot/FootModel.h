//
//  FootModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/6.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol FootModel @end
@interface FootModel : JSONModel
@property (assign, nonatomic) NSInteger commissionRate;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *goodkey;
@property (strong, nonatomic) NSString *picUrl;
@property (assign, nonatomic) CGFloat price;
@property (assign, nonatomic) CGFloat priceOld;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL tejie;
@end
