//
//  InviteModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/14.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol InviteModel @end
@interface InviteModel : JSONModel
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *remoney;
@property (strong, nonatomic) NSString *mmoney;
@end
