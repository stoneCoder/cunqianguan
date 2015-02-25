//
//  JYHModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol JYHModel @end
@interface JYHModel : JSONModel
@property (strong,nonatomic) NSString *iosid;
@property (strong,nonatomic) NSString *title;
@property (assign,nonatomic) CGFloat price;
@property (assign,nonatomic) CGFloat price_old;
@property (strong,nonatomic) NSString *pic_url;
@property (assign,nonatomic) NSInteger qcount;
@property (assign,nonatomic) NSInteger status;

@property (assign,nonatomic) NSInteger today;
@property (strong,nonatomic) NSString *xiaob;
@property (assign,nonatomic) NSInteger zk;
@end
