//
//  SignDataModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/3.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "SignModel.h"
@interface SignDataModel : JSONModel
@property (strong, nonatomic) NSArray<SignModel> *logs;
@property (assign, nonatomic) NSInteger nextReward;
@property (assign, nonatomic) NSInteger todayReward;
@property (strong, nonatomic) NSString *ptime;
@end
