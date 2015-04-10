//
//  TeJiaModel.m
//  cunqianguan
//
//  Created by 四三一八 on 15/4/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "TeJiaModel.h"

@implementation TeJiaModel
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"price_old": @"priceOld",
                                                       @"num_iid":@"numId",
                                                       @"pic_url":@"picUrl"
                                                       }];
}
@end
