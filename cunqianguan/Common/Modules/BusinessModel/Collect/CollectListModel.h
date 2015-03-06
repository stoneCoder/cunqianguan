//
//  CollectListModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/6.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "CollectModel.h"
@interface CollectListModel : JSONModel
@property (strong, nonatomic) NSArray<CollectModel> *data;
@end
