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

-(void)addTrace:(NSString *)userId
        goodKey:(NSString *)goodKey
          title:(NSString *)title
         picUrl:(NSString *)picUrl
          price:(NSString *)price
        success:(void (^)(id json))success
        failure:(void (^)( NSError *err))failure
{
    NSString *url = @"addTrace";
    NSDictionary *dic =  @{@"uid":userId,@"goodkey":goodKey,@"title":title,@"pic_url":picUrl,@"price":price};
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

-(void)getTaobaoProductInfo:(NSString *)productId
                    success:(void (^)(id json))success
                    failure:(void (^)( NSError *err))failure
{
    NSString *url = @"http://hws.m.taobao.com/cache/wdetail/5.0/";
    url = [NSString stringWithFormat:@"%@?id=%@",url,productId];
    NSDictionary *dic =  @{@"productId":productId};
    [BaseConnect postAbsolutePath:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(NSError *e) {
        failure(e);
    }];
}
@end
