//
//  ExChangeAttrListModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "ExChangeAttr.h"
@interface ExChangeAttrListModel : JSONModel
@property (strong, nonatomic) NSArray<ExChangeAttr> *data;
@end
