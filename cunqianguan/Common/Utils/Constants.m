//
//  Constants.m
//  manpower
//
//  Created by WangShunzhou on 14-9-12.
//  Copyright (c) 2014年 WHZM. All rights reserved.
//

#import "Constants.h"

//你猜不到我的密码吧？用于加密数据
NSString *const kCryptPwd = @"com.baoxianqi.www";

// 个人资料保存地址
NSString *const kCryptFilePath = @"Library/Application Support/001.dat";

// 历史用户保存地址
NSString *const kUsernameList = @"Library/001.dat";

// 头像图片宽度
CGFloat const kPhotoSizeWidth = 144.0f;

// 按钮默认颜色enable
NSInteger const kEnabledColor = 0xff0000;

// 按钮默认颜色disable
NSInteger const kDisabledColor = 0xEF7F87;

NSString *const kUploadPath = @"http://192.168.20.240/~zhouqiang/upload_file.php/?";

NSString *const kImagePath = @"http://192.168.20.240/~zhouqiang/";

NSString *const shareURL = @"http://www.baoxianqi.com";
//友盟AppKey
NSString *const UMengAppKey = @"54dd53cefd98c57dcf000736";
//微信AppKey&AppID
NSString *const WeChatAppKey = @"d79893620d4851faea30eb26e1221cbc";
NSString *const WeChatAppID  = @"wx9af45d9c2a6fd036";
//QQ AppKey&AppID
NSString *const QQAppKey = @"dA20dR13RcQV3GnR";
NSString *const QQAppID = @"1102956721";