//
//  RankingModel.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "RankingModel.h"

@implementation RankingModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"reward_money": @"rewardMoney"
                                                       }];
}
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end
