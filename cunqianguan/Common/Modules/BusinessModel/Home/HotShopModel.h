//
//  HotShopModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/5.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol HotShopModel @end
@interface HotShopModel : JSONModel
@property (strong, nonatomic) NSString *fanli;
@property (strong, nonatomic) NSString *fanliUrl;
@property (strong, nonatomic) NSString *logo;
@property (assign, nonatomic) NSInteger mallId;
@property (strong, nonatomic) NSString *mallName;
@property (assign, nonatomic) NSInteger unionId;
@property (assign, nonatomic) NSInteger yiqifaid;
@property (strong, nonatomic) NSString *yiqifaurl;
@end
