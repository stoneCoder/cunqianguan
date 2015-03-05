//
//  BankInfoListModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/5.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "CityModel.h"
@interface CityListModel : JSONModel
@property (strong, nonatomic) NSArray<CityModel> *data;
@end
