//
//  ExChangeListModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "ExChangeModel.h"
@interface ExChangeListModel : JSONModel
@property (strong, nonatomic) NSArray<ExChangeModel> *data;
@end
