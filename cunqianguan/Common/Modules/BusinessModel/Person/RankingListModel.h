//
//  RankingListModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "RankingModel.h"
@interface RankingListModel : JSONModel
@property (strong, nonatomic) NSArray<RankingModel> *data;
@end
