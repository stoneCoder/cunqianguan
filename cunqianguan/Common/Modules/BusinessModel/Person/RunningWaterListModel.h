//
//  RunningWaterListModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/2.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "RunningWaterModel.h"
@interface RunningWaterListModel : JSONModel
@property (strong, nonatomic) NSArray<RunningWaterModel> *data;
@end
