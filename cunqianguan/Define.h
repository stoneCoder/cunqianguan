//
//
//  Define.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/20.
//  Copyright (c) 2015年 4318. All rights reserved.
//

//#define API @"http://www.baoxianqi.com/MobileApi/"
#define API @"http://deve.baoxianqi.com/MobileApi/"
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
#define DATA_LOAD @"加载中。。"
#define LOGIN_LOAD @"登陆中。。"
#define ACTION_LOAD @"处理中。。"
#define HUD_SHOW_SECOND 2
#define PAGE_COUNT 20
#define MENU_ARRAY @[@"热卖", @"男装", @"女装", @"居家", @"母婴", @"鞋包", @"配饰", @"美食", @"数码", @"美妆", @"热卖"]
#define SELECT_ARRAY  @[@"全部",@"时尚女装",@"流行男装",@"母婴玩具",@"数码家电",@"家居家纺",@"美容护肤",@"美食茗茶"];
#define SELECT_ID @[@"0",@"1", @"8", @"16", @"22", @"29",@"36", @"43"];
#define INTERFACE_VERSION @"2.0"
#define TIPS_ARRAY @[@"小贴士：见你所爱，勿忘收藏",@"小贴士：长按商品，即取消收藏",@"小贴士：足迹，留下您所浏览的商品返利",@"小贴士：淘宝新规，确认收货才见订单",@"小贴士：同类APP，保鲜期返利最高哦",@"小贴士：凡返利购商品，俱详细返利比",@"小贴士：手机签到，得额外奖励"]

#define SHARE_CONTEXT(money,url) [NSString stringWithFormat:@"只要%.2f元,刚刚在 @保鲜期官网 上发现了这个宝贝，非常喜欢，还有返利，赶快来抢吧！%@",money,url];
#define BASE_URL @"www.baoxianqi.com/"

#define SHARE_QQ_URL(goodKey,userId) [NSString stringWithFormat:@"%@juyouhui/goods?id=%@&pf=qz&uid=",BASE_URL,goodKey,userId];

#define SHARE_WX_URL(goodKey,userId) [NSString stringWithFormat:@"%@juyouhui/goods?id=%@&pf=wx&uid=",BASE_URL,goodKey,userId];

#define SHARE_WC_URL(goodKey,userId) [NSString stringWithFormat:@"%@juyouhui/goods?id=%@&pf=wc&uid=",BASE_URL,goodKey,userId];

#define SHARE_WB_URL(goodKey,userId) [NSString stringWithFormat:@"%@juyouhui/goods?id=%@&pf=wb&uid=",BASE_URL,goodKey,userId];
