//
//  LocalWebVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseWebVC.h"

@interface LocalWebVC : BaseWebVC
@property (assign, nonatomic) NSInteger loadType;
-(void)loadWebView;
@end
