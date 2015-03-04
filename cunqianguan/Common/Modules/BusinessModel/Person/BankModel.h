//
//  BankModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/4.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"

@interface BankModel : JSONModel
@property (strong, nonatomic) NSString *alipay;
@property (strong, nonatomic) NSString *bank;
@property (strong, nonatomic) NSString *bankname;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *name;
@end
