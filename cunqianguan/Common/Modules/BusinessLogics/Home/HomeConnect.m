//
//  HomeConnect.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HomeConnect.h"
#import "BaseConnect.h"
#import "Constants.h"
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


-(void)gethotmalllist:(NSString *)userId
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure
{
    NSString *url = @"gethotmalllist";
    userId = userId?userId:@"";
    NSDictionary *dic = @{@"uid":userId};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)searchByText:(NSString *)text
            success:(void (^)(id json))success
            failure:(void (^)( NSError *err))failure
{
    NSString *searchUrl = [NSString stringWithFormat:@"%@%@",SEARCH_URL,text];
    searchUrl = [searchUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [BaseConnect postAbsolutePath:searchUrl Parameters:[NSDictionary dictionary] success:^(id json) {
        success(json);
    } failure:^(NSError *e) {
        failure(e);
    }];
}
@end
