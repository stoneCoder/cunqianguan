//
//  SignVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/9.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseVC.h"
#import "JTCalendar.h"
@interface SignVC : BaseVC
@property (strong, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;
@end
