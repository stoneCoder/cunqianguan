//
//  BankInfoModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/5.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol CityModel @end
@interface CityModel : JSONModel
@property (assign, nonatomic) NSInteger cityId;
@property (strong, nonatomic) NSString *name;
@end
