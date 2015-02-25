//
//  AdListModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "AdModel.h"
@interface AdListModel : JSONModel
@property (strong,nonatomic) NSArray<AdModel> *data;
@end
