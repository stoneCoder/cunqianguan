//
//  SMNavigationBar.h
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-18.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import <UIKit/UIKit.h>

// UINavigationBar

@class SMNavigationItem;

@interface SMNavigationBar : UIControl

@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) UIView *rightView;

@end
