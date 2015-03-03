//
//  SignModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/3.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol SignModel @end
@interface SignModel : JSONModel
@property (assign, nonatomic) BOOL comb; //是否连续签到
@property (assign, nonatomic) BOOL issign; //是否签到
@property (assign, nonatomic) NSInteger phone; //签到渠道
@property (assign, nonatomic) NSInteger showday; //显示日期
@property (assign, nonatomic) NSInteger showdayios; //显示日期
@end
