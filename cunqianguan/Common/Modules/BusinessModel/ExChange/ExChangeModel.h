//
//  ExChangeModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol ExChangeModel @end
@interface ExChangeModel : JSONModel
@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) NSString *cate_id;
@property (strong, nonatomic) NSString *pic_url;
@property (assign, nonatomic) NSInteger in_stock;
@property (assign, nonatomic) NSInteger point;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger use_types;
@end
