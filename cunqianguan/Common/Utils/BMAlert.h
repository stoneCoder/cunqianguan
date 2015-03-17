//
//  BMAlert.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/12.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DoAlertView;
typedef void(^DoActionViewHandler)(DoAlertView *alertView);
@interface BMAlert : NSObject
DEFINE_SINGLETON_FOR_HEADER(BMAlert)
- (void)alert:(NSString *)aMessage cancle:(DoActionViewHandler)cancle other:(DoActionViewHandler)other;
- (void)alertTextFieldWithplaceholder:(NSString *)placeholderText Cancle:(DoActionViewHandler)cancle other:(DoActionViewHandler)other;
@end
