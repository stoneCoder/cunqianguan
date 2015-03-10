//
//  TBUrlUtil.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ViewType) {
    NOT_TB_URL,
    TB_ORI_DETAIL_URL,
    TM_ORI_DETAIL_URL,
    TB_REBATE_FINAL_DETAIL_URL,
    TM_REBATE_FINAL_DETAIL_URL,
    JUHUASUAN_DETAIL_URL,
    JUHUASUAN_MAIN_URL
};
@interface TBUrlUtil : NSObject
DEFINE_SINGLETON_FOR_HEADER(TBUrlUtil)
+ (NSInteger)matchUrlWithWebSite:(NSString *)str;
+ (NSString *)getTBItemId:(NSString *)url;
@end
