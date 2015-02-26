//
//  MsgModel.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JSONModel.h"
@protocol MsgModel @end
@interface MsgModel : JSONModel
@property (strong,nonatomic) NSString *iosid;
@property (strong,nonatomic) NSString *addTime;
@property (strong,nonatomic) NSString *addtime_date;
@property (strong,nonatomic) NSString *addtime_show;
@property (strong,nonatomic) NSString *contents;
@property (strong,nonatomic) NSString *title;
@property (assign,nonatomic) NSInteger is_see;
@property (assign,nonatomic) NSInteger types; //0 通知 1 公告
@end
