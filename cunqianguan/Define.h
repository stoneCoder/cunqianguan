//
//
//  Define.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/20.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#define API @"http://www.baoxianqi.com/MobileApi/"
//#define API @"http://deve.baoxianqi.com/MobileApi/"
#pragma mark - 单例

#define DEFINE_SINGLETON_FOR_HEADER(className) \
+ (className *)shared##className;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}


#pragma mark - 颜色
#define UIColorFromRGBA(rgb,a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:a]
#define UIColorFromRGB(rgb) UIColorFromRGBA(rgb,1.0f)


#pragma mark - 适配
// 判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
//判断是否时iphone5
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGTH [UIScreen mainScreen].bounds.size.height
#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height

#pragma mark - 其他
#define ccp CGPointMake
#define DATA_LOAD @"正在加载。。"
#define LOGIN_LOAD @"登陆中。。"
#define ACTION_LOAD @"处理中。。"
#define HUD_SHOW_SECOND 2
#define PAGE_COUNT 20
#define MENU_ARRAY @[@"全部", @"男装", @"女装", @"居家", @"母婴", @"鞋包", @"配饰", @"美食", @"数码", @"美妆", @"热卖"]
#define SELECT_ARRAY  @[@"全部",@"时尚女装",@"流行男装",@"母婴玩具",@"数码家电",@"家居家纺",@"美容护肤",@"美食茗茶"];
#define SELECT_ID @[@"0",@"1", @"8", @"16", @"22", @"29",@"36", @"43"];
#define INTERFACE_VERSION @"2.0"
