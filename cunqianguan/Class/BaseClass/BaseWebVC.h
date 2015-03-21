//
//  BaseWebVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/4.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseVC.h"

@interface BaseWebVC : BaseVC
@property(strong, nonatomic) IBOutlet UIWebView *webView;
@property(assign, nonatomic) BOOL isTrueTrance; //标记是否从返利够/聚优惠进入 NO 从返利够/聚优惠进入 YES 逛淘宝
-(void)showLoaderView:(UIView *)view;
-(void)showLoaderView;
-(void)hideLoaderView;
-(void)hideProgressView;
@end
