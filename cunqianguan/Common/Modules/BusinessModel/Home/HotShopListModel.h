//
//  HotShopListModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/5.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
#import "HotShopModel.h"
@interface HotShopListModel : JSONModel
@property (strong, nonatomic) NSArray<HotShopModel> *data;
@end
