//
//  MongoModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol MongoModel @end
@interface MongoModel : JSONModel
@property (strong,nonatomic) NSString *mall_name;
@property (strong,nonatomic) NSString *title;
@property (assign,nonatomic) CGFloat price;
@property (assign,nonatomic) CGFloat price_old;
@property (strong,nonatomic) NSString *pic_url;
@property (assign,nonatomic) NSInteger volume;
@property (assign,nonatomic) NSInteger commission_rate;
@property (strong,nonatomic) NSString *goodkey;
@end
