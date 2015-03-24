//
//  BaseVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface BaseView : UIView
/**
 *  功能:显示hud
 */
- (void)showHUD;

/**
 *  功能:显示字符串hud
 */
- (void)showHUD:(NSString *)aMessage;
- (void)showHUD:(NSString *)aMessage animated:(BOOL)animated;

/**
 *  功能:显示字符串hud几秒钟时间
 */
- (void)showStringHUD:(NSString *)aMessage second:(int)aSecond;

/**
 *  功能:隐藏hud
 */
- (void)hideHUD;
- (void)hideHUD:(BOOL)animated;
- (void)hideAllHUD;

/**
 *  功能:接口请求失败
 */
-(void)failureHideHUD;
@end
