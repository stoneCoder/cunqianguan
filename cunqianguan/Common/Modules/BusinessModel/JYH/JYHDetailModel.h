//
//  JYHDetailModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "JYHAttrModel.h"
#import "JYHItemModel.h"
@protocol JYHDetailModel @end
@interface JYHDetailModel : JSONModel
@property (strong, nonatomic) NSArray<JYHAttrModel> *attr;
@property (strong , nonatomic) NSString *express;
@property (strong , nonatomic) NSString *fanli_url;
@property (strong , nonatomic) NSString *productId;
@property (strong , nonatomic) NSString *item_id;
@property (strong , nonatomic) NSString *pic_url;
@property (assign , nonatomic) CGFloat price;
@property (assign , nonatomic) CGFloat price_old;
@property (assign , nonatomic) NSInteger qcount;
@property (strong, nonatomic) NSArray<JYHItemModel> *rec;
@property (assign, nonatomic) NSInteger status;
@property (assign, nonatomic) NSInteger time;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger today;
@property (strong, nonatomic) NSString *xiaob;
@property (assign, nonatomic) CGFloat zk;
@end
