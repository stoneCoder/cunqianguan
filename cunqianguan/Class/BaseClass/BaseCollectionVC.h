//
//  BaseCollectionVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CMAlert.h"

@interface BaseCollectionVC : UICollectionViewController
@property (strong,nonatomic) NSString *leftTitle;
/**
 *  功能:设置导航栏个性化标题
 */
- (void)setTitleText:(NSString *)aTitleText;
//隐藏返回按钮
-(void)hideReturnBackButton;

-(void)setReturnBtnTitle:(NSString *)aTitle WithImage:(NSString *)imageName;

-(void)setRefreshEnabled:(BOOL)enabled;
//显示hud
- (void)showHUD;
//隐藏hud
- (void)hideHUD;
- (void)hideAllHUD;
//显示字符串hud
- (void)showHUD:(NSString *)aMessage;
//显示字符串hud几秒钟时间
- (void)showStringHUD:(NSString *)aMessage second:(int)aSecond;
/**
 *  功能:接口请求失败
 */
-(void)failureHideHUD;

-(void)refresh;
-(void)moreFresh;
@end
