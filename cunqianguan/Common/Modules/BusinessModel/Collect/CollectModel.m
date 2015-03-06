//
//  CollectModel.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/6.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "CollectModel.h"

@implementation CollectModel
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"commission_rate": @"commissionRate",
                                                       @"pic_url": @"picUrl",
                                                       @"price_old": @"priceOld",
                                                       @"item_url":@"itemUrl"
                                                       }];
}
@end
