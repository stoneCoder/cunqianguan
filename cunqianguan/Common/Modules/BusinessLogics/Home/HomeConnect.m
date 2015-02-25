//
//  HomeConnect.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HomeConnect.h"
#import "BaseConnect.h"

@implementation HomeConnect
DEFINE_SINGLETON_FOR_CLASS(HomeConnect)

-(void)getIndexAdWith:(NSDictionary *)dic
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure;
{
    NSString *url = @"indexAd";
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}
@end
