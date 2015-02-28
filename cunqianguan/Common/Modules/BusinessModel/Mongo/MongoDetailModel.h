//
//  MongoDetailModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"

@interface MongoDetailModel : JSONModel
@property (strong, nonatomic) NSString *commets;
@property (strong, nonatomic) NSString *fan_url;
@property (assign, nonatomic) NSInteger fanli;
@property (assign, nonatomic) NSInteger isfav;
@property (strong, nonatomic) NSString *mall_name;
@property (strong, nonatomic) NSString *pic_url;
@property (assign, nonatomic) CGFloat price;
@property (assign, nonatomic) CGFloat price_old;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger volume;
@end
