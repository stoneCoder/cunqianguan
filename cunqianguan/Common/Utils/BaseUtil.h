//
//  BaseUtil.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@interface BaseUtil : NSObject

+ (NSString *) stringFromMD5:(NSString*)string;
+ (NSString *) stringFromBASE64:(NSString*)string;

+ (NSString *)transformLongToStrDate:(long)dateTimeLong WithType:(NSString *)type;
+ (NSDate *)transformLongToDate:(long)dateTimeLong WithType:(NSString *)type;

+(float)getHeightByString:(NSString *)text font:(UIFont *)widthfont allwidth:(float)allwidth;
+(float)getWidthByString:(NSString *)text font:(UIFont *)widthfont allheight:(float)allheight andMaxWidth:(float)width;

+(CGSize)sizeOfTextInFont:(NSString*)text width:(CGFloat)width height:(CGFloat)height font:(UIFont*)font;

#pragma -------------获取通讯录信息
//+(NSMutableArray *)getAddressBookPersonInfo;

+(BOOL)isPhoneNum:(NSString *)telphone;
#pragma mark NSDictionary或NSArray转化为JSON串
+ (NSString *)toJSONData:(id)theData;
+(NSArray *)readCityTxt;

+ (NSString*)encrypt:(NSString*)toBeEncString;
+ (NSString *)hmac_sha1:(NSString *)data secret:(NSString *)key;

+ (NSString *)hexStringFromString:(NSString *)string;
@end


