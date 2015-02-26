//
//  BaseVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - hud
/**
 *  功能:显示hud
 */
- (void)showHUD{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}

/**
 *  功能:显示字符串hud
 */
- (void)showHUD:(NSString *)aMessage
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = aMessage;
}

- (void)showHUD:(NSString *)aMessage animated:(BOOL)animated
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:animated];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = aMessage;
}

/**
 *  功能:显示字符串hud几秒钟时间
 */
- (void)showStringHUD:(NSString *)aMessage second:(int)aSecond{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aMessage;
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:aSecond];
}

/**
 *  功能:隐藏hud
 */
- (void)hideHUD
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}

/**
 *  功能:隐藏所有hud
 */
- (void)hideAllHUD
{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}

/**
 *  功能:隐藏hud
 */
- (void)hideHUD:(BOOL)animated
{
    [MBProgressHUD hideHUDForView:self animated:animated];
}

/**
 *  功能:接口请求失败
 */
-(void)failureHideHUD{
    [self hideHUD];
    //[[CMAlert sharedCMAlert] alert:@"当前网络不稳定，请检查你的网络!"];
}
@end
