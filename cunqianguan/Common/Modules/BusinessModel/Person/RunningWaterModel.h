//
//  RunningWaterModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/2.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol RunningWaterModel @end
@interface RunningWaterModel : JSONModel
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *extends;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *time;
@end
