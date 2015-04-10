//
//  TeJiaModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/4/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol TeJiaModel @end
@interface TeJiaModel : JSONModel
@property (strong,nonatomic) NSString *numId;
@property (strong,nonatomic) NSString *mallId;
@property (strong,nonatomic) NSString *title;
@property (assign,nonatomic) CGFloat price;
@property (assign,nonatomic) CGFloat priceOld;
@property (assign,nonatomic) CGFloat mobilePriceOff;
@property (assign,nonatomic) CGFloat discount;
@property (strong,nonatomic) NSString *picUrl;
@property (strong,nonatomic) NSString *url;
@property (assign,nonatomic) BOOL isNew;

@end
