//
//  JYHListModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "JYHModel.h"
@interface JYHListModel : JSONModel
@property (strong,nonatomic) NSArray<JYHModel> *data;
@end
