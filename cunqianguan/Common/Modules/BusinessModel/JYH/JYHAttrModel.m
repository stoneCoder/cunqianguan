//
//  JYHAttrModel.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JYHAttrModel.h"

@implementation JYHAttrModel
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"border-color": @"borderColor"
                                                       }];
}
@end
