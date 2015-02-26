//
//  MsgListModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "MsgModel.h"
@interface MsgListModel : JSONModel
@property (strong, nonatomic) NSArray<MsgModel> *data;
@end
