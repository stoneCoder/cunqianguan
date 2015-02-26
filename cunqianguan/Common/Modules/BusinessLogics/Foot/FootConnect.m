//
//  FootConnect.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "FootConnect.h"
#import "BaseConnect.h"
@implementation FootConnect
DEFINE_SINGLETON_FOR_CLASS(FootConnect)

-(void)addTrace:(NSString *)userId
    withGoodKey:(NSString *)goodKey
        success:(void (^)(id json))success
        failure:(void (^)( NSError *err))failure
{
    NSString *url = @"addTrace";
    NSDictionary *dic =  @{@"uid":userId,@"goodkey":goodKey};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getTraceGoods:(NSString *)userId
            withPage:(NSInteger)page
             success:(void (^)(id json))success
             failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getTraceGoods";
    NSDictionary *dic =  @{@"uid":userId,@"goodkey":@(page)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)delTrace:(NSString *)userId
    withGoodKey:(NSString *)goodKey
        success:(void (^)(id json))success
        failure:(void (^)( NSError *err))failure
{
    NSString *url = @"delTrace";
    NSDictionary *dic =  @{@"uid":userId,@"goodkey":goodKey};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}
@end
