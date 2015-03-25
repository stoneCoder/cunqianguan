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
               WithAble:(NSInteger)able
              category:(NSInteger)category
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getExchangeList";
    userId = userId?userId:@"";
    NSDictionary *dic = @{@"uid":userId,@"able":@(able),@"category":@(category)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)exchangeGoodsDetail:(NSString *)productId
                   success:(void (^)(id json))success
                   failure:(void (^)( NSError *err))failure
{
    NSString *url = @"exchangeGoodsDetail";
    NSDictionary *dic = @{@"id":productId};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)exchangeGood:(NSString *)username
                pwd:(NSString *)password
          productId:(NSString *)productId
              phone:(NSString *)phone
                 qq:(NSString *)qq
                   success:(void (^)(id json))success
                   failure:(void (^)( NSError *err))failure
{
    NSString *url = @"exchangeGoods";
    NSDictionary *dic = @{@"email":username,@"password":password,@"id":productId,@"phone":phone,@"qq":qq};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getExchangeCateArr:(NSString *)uid
                  success:(void (^)(id json))success
                  failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getExchangeCateArr";
    NSDictionary *dic = @{@"uid":uid};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}
@end
