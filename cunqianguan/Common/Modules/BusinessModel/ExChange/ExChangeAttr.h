//
//  ExChangeAttr.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol ExChangeAttr @end
@interface ExChangeAttr : JSONModel
@property (strong, nonatomic) NSString *attrId;
@property (strong, nonatomic) NSString *name;
@end
