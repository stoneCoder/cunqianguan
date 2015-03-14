//
//  InviteListModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/14.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "InviteModel.h"
@interface InviteListModel : JSONModel
@property (strong, nonatomic) NSArray<InviteModel> *moneylog;
@end
