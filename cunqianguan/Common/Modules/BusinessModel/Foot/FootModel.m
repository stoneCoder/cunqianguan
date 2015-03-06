//
//  FootModel.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/6.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "FootModel.h"

@implementation FootModel
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
                                                       }];
}
@end
