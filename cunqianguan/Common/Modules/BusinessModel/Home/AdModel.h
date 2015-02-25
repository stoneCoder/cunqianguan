//
//  AdModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol AdModel @end
@interface AdModel : JSONModel
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *extends;
@property (strong, nonatomic) NSString *pic_url;
@property (assign, nonatomic) NSInteger type;
@end
