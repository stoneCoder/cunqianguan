//
//  ExChangeAttr.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ExChangeAttr.h"

@implementation ExChangeAttr
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"attrId"
                                                       }];
}
@end
