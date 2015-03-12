//
//  TBUrlUtil.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "TBUrlUtil.h"
#import "Constants.h"
@implementation TBUrlUtil
DEFINE_SINGLETON_FOR_CLASS(TBUrlUtil)

+ (NSInteger)matchUrlWithWebSite:(NSString *)str
{
    NSPredicate *pred_tb_rebeate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",TB_REBATE_FINAL_DETAIL_URL_REG];
    NSPredicate *pred_tm_rebate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",TM_REBATE_FINAL_DETAIL_URL_REG];
    NSPredicate *pred_tb_ori = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",TB_ORI_DETAIL_URL_REG];
    NSPredicate *pred_tm_ori = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",TM_ORI_DETAIL_URL_REG];
    NSPredicate *pred_juhuasuan_detail = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",JUHUASUAN_DETAIL_URL_REG];
    NSPredicate *pred_juhuasuan_main = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",JUHUASUAN_MAIN_URL_REG];
    
    if ([pred_tb_rebeate evaluateWithObject:str]) {
        return TB_REBATE_FINAL_DETAIL_URL;
    } else if ([pred_tm_rebate evaluateWithObject:str]) {
        return TM_REBATE_FINAL_DETAIL_URL;
    } else if ([pred_tb_ori evaluateWithObject:str]) {
        return TB_ORI_DETAIL_URL;
    } else if ([pred_tm_ori evaluateWithObject:str]) {
        return TM_ORI_DETAIL_URL;
    } else if ([pred_juhuasuan_detail evaluateWithObject:str]) {
        return JUHUASUAN_DETAIL_URL;
    } else if ([pred_juhuasuan_main evaluateWithObject:str]) {
        return JUHUASUAN_MAIN_URL;
    }
    return NOT_TB_URL;
}


+ (NSString *)getTBItemId:(NSString *)url
{
    NSString *itemId;
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"id=([^&]+)" options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:url options:0 range:NSMakeRange(0, [url length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            //从urlString当中截取数据
            itemId = [[url substringWithRange:resultRange] substringFromIndex:3];
            
            //输出结果 NSLog(@"access url is %@------------->product id is %@",url,itemId);
        }
    }
    return  itemId;
}
@end
