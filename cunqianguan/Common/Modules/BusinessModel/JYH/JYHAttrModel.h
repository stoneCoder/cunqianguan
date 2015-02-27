//
//  JYHAttrModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol JYHAttrModel @end
@interface JYHAttrModel : JSONModel
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *borderColor;
@end
