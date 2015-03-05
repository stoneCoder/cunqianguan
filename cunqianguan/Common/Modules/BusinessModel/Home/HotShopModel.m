//
//  HotShopModel.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/5.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HotShopModel.h"

@implementation HotShopModel
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"fanli_url": @"fanliUrl",
                                                       @"mall_id":@"mallId",
                                                       @"mall_name":@"mallName",
                                                       @"union_id":@"unionId"
                                                       }];
}
@end
