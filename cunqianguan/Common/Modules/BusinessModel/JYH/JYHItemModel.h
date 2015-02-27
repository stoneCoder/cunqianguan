//
//  JYHItemModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol JYHItemModel @end
@interface JYHItemModel : JSONModel
@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) NSString *pic_url;
@property (assign, nonatomic) CGFloat price;
@property (assign, nonatomic) CGFloat price_old;
@property (strong, nonatomic) NSString *title;
@end
