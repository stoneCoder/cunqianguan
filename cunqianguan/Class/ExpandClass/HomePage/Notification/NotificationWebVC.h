//
//  NotificationWebVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseWebVC.h"

@interface NotificationWebVC : BaseWebVC<UIWebViewDelegate>
@property (strong, nonatomic) NSString *urlPath;
@property (strong, nonatomic) NSDictionary *remoteDic;
@end
