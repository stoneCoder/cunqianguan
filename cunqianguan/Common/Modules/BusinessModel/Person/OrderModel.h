//
//  OrderModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol OrderModel @end
@interface OrderModel : JSONModel
@property (strong, nonatomic) NSString *date;
@property (assign, nonatomic) NSInteger fanli;
@property (strong, nonatomic) NSString *mall;
@property (assign, nonatomic) CGFloat pay_price;
@property (strong, nonatomic) NSString *pic_url;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *trade_id;
@property (assign, nonatomic) NSInteger type;
@property (strong, nonatomic) NSString *goodkey;
@end
