//
//  RankingModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol RankingModel @end
@interface RankingModel : JSONModel
@property (strong, nonatomic) NSString *username;
@property (assign, nonatomic) NSInteger rewardMoney;
@end
