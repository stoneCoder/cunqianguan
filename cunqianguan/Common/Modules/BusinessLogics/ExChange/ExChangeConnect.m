//
//  ExChangeConnect.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ExChangeConnect.h"
#import "BaseConnect.h"

@implementation ExChangeConnect
DEFINE_SINGLETON_FOR_CLASS(ExChangeConnect)
-(void)getExchangeList:(NSString *)userId
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getExchangeList";
    userId = userId?userId:@"";
    NSDictionary *dic = @{@"uid":userId};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}
@end
