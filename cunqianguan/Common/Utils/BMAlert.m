//
//  BMAlert.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/12.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BMAlert.h"
#import "DoAlertView.h"

@interface BMAlert()
@property(nonatomic, assign) BOOL alertShowing;//是否已弹出alert view
@end

@implementation BMAlert
DEFINE_SINGLETON_FOR_CLASS(BMAlert)
- (void)alert:(NSString *)aMessage cancle:(DoActionViewHandler)cancle other:(DoActionViewHandler)other
{
    DoAlertView *alertView = [[DoAlertView alloc] init];
    alertView.nAnimationType = DoTransitionStyleFade;
    alertView.dRound = 10.0;
    alertView.bDestructive = NO;
    if (!other) {
        [alertView doYesNo:@"提示" body:aMessage cancleButton:@"确定" yes:^(DoAlertView *alertView) {
            cancle(alertView);
        }];
    }else{
        [alertView doYesNo:@"提示" body:aMessage cancleButton:@"确定" otherButton:@"取消" yes:^(DoAlertView *alertView) {
            cancle(alertView);
        } no:^(DoAlertView *alertView) {
            other(alertView);
        }];
    }
    alertView = nil;
}

-(void)alertTextFieldWithplaceholder:(NSString *)placeholderText Cancle:(DoActionViewHandler)cancle other:(DoActionViewHandler)other
{
    DoAlertView *alertView = [[DoAlertView alloc] init];
    alertView.nAnimationType = DoTransitionStyleFade;
    alertView.dRound = 10.0;
    alertView.bDestructive = NO;
    [alertView doTextFieldYesNo:@"提示" placeholder:placeholderText cancleButton:@"确定" otherButton:@"取消" yes:^(DoAlertView *alertView) {
        cancle(alertView);
    } no:^(DoAlertView *alertView) {
        other(alertView);
    }];
    alertView = nil;
}
@end
