//
//  JSONValueTransformer+CustomTransformer.m
//  Cntianran
//
//  Created by hanjin on 14-9-2.
//  Copyright (c) 2014年 INMEDIA. All rights reserved.
//

#import "JSONValueTransformer+CustomTransformer.h"
#define APIDateFormat @"yyyy-MM-dd HH:mm:ss"
@implementation JSONValueTransformer (CustomTransformer)
- (NSDate *)NSDateFromNSString:(NSString*)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:APIDateFormat];
    return [formatter dateFromString:string];
}

- (NSString *)JSONObjectFromNSDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:APIDateFormat];
    return [formatter stringFromDate:date];
}

@end
