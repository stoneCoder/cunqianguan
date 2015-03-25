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
#define MENU_ARRAY @[@"热卖", @"女装", @"鞋包", @"美妆", @"美食", @"配饰", @"数码", @"居家", @"母婴", @"男装"]
#define MENU_ID @[@"10", @"2", @"5", @"9", @"7", @"6", @"8",@"3", @"4", @"1"];
#define SELECT_ARRAY  @[@"全部",@"时尚女装",@"流行男装",@"母婴玩具",@"数码家电",@"家居家纺",@"美容护肤",@"美食茗茶"];
#define SELECT_ID @[@"0",@"1", @"8", @"16", @"22", @"29",@"36", @"43"];

#define INTERFACE_VERSION @"2.0"
#define TIPS_ARRAY @[@"小贴士：见你所爱，勿忘收藏",@"小贴士：长按商品，即取消收藏",@"小贴士：足迹，留下您所浏览的商品返利",@"小贴士：淘宝新规，确认收货才见订单",@"小贴士：同类APP，保鲜期返利最高哦",@"小贴士：凡返利购商品，俱详细返利比",@"小贴士：手机签到，得额外奖励"]

#define SHARE_CONTEXT(money) [NSString stringWithFormat:@"只要%.2f元,刚刚在 @保鲜期官网 上发现了这个宝贝，非常喜欢，还有返利，赶快来抢吧！",money];
#define BASE_URL @"http://www.baoxianqi.com/"

#define SHARE_WX_TITLE @"保鲜期APP手机购物高达90%的返利金额，更有新玩法（我的足迹）助您易GO即返！下载即送5元红包！"
#define SHARE_WX_CONTENT @"告别于传统返利操作，保鲜期新的足迹能帮您轻松购物，一键返现，更有远超其他平台的返现优惠等你来拿，赶快参与体验吧！"

#define SHARE_TITLE(price,fanprice) [NSString stringWithFormat:@"真返钱啦！我买了%.2f竟然返我%.2f的现金，能省就省，积少成多，小伙伴们快来这里参与吧",price,fanprice];
#define SHARE_CONTENT @"告别于传统返利操作，保鲜期（www.baoxianqi.com）新的足迹功能帮您轻松购物，一键返现，更有远超其他平台的返现优惠等你来拿，赶快参与体验吧！"

#define SHARE_QQ_JYH_URL(goodKey,userId) [NSString stringWithFormat:@"%@juyouhui/goods?id=%@&pf=qz&uid=%@",BASE_URL,goodKey,userId];
#define SHARE_WX_JYH_URL(goodKey,userId) [NSString stringWithFormat:@"%@juyouhui/goods?id=%@&pf=wx&uid=%@",BASE_URL,goodKey,userId];
#define SHARE_WC_JYH_URL(goodKey,userId) [NSString stringWithFormat:@"%@juyouhui/goods?id=%@&pf=wc&uid=%@",BASE_URL,goodKey,userId];
#define SHARE_WB_JYH_URL(goodKey,userId) [NSString stringWithFormat:@"%@juyouhui/goods?id=%@&pf=wc&uid=%@",BASE_URL,goodKey,userId];

#define SHARE_QQ_URL(goodKey,userId) [NSString stringWithFormat:@"%@item/%@.html?&pf=qz&uid=%@",BASE_URL,goodKey,userId];
#define SHARE_WX_URL(goodKey,userId) [NSString stringWithFormat:@"%@item/%@.html?&pf=wx&uid=%@",BASE_URL,goodKey,userId];
#define SHARE_WC_URL(goodKey,userId) [NSString stringWithFormat:@"%@item/%@.html?&pf=wc&uid=%@",BASE_URL,goodKey,userId];
#define SHARE_WB_URL(goodKey,userId) [NSString stringWithFormat:@"%@item/%@.html?&pf=wb&uid=%@",BASE_URL,goodKey,userId];

#define SEARCH_URL(searchText,mm,userId) [NSString stringWithFormat:@"http://ai.m.taobao.com/search.html?q=%@&pid=%@&unid=%@",searchText,mm,userId]
