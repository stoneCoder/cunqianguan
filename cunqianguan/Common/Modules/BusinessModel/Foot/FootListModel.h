//
//  FootListModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/6.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "FootModel.h"
@interface FootListModel : JSONModel
@property (strong, nonatomic) NSArray<FootModel> *data;
@end
