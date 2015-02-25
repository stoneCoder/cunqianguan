//
//  JSONValueTransformer+CustomTransformer.h
//  Cntianran
//
//  Created by hanjin on 14-9-2.
//  Copyright (c) 2014年 INMEDIA. All rights reserved.
//

#import "JSONValueTransformer.h"

@interface JSONValueTransformer (CustomTransformer)
- (NSDate *)NSDateFromNSString:(NSString*)string;
- (NSString *)JSONObjectFromNSDate:(NSDate *)date;
@end
