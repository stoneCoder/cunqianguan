//
//  PersonConnect.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PersonConnect.h"
#import "BaseConnect.h"
@implementation PersonConnect
DEFINE_SINGLETON_FOR_CLASS(PersonConnect)

-(void)updateAvatar:(NSString *)email
            withPwd:(NSString *)pwd
            success:(void (^)(id json))success
            failure:(void (^)( NSError *err))failure
{
    
}

-(void)getOrderInfo:(NSString *)email
            pwd:(NSString *)pwd
           withType:(NSInteger)type
            andPage:(NSInteger)page
            success:(void (^)(id json))success
            failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getOrderInfo";
    NSDictionary *dic =  @{@"email":email,@"password":pwd,@"type":@(type),@"page":@(page),@"perpage":@(PAGE_COUNT)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getUserFavorite:(NSString *)userId
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getUserFavorite";
    NSDictionary *dic =  @{@"uid":userId};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)addUserFavorite:(NSString *)userId
           withGoodKey:(NSString *)goodKey
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure
{
    NSString *url = @"addUserFavorite";
    NSDictionary *dic =  @{@"uid":userId,@"goodkey":goodKey};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)delUserFavorite:(NSString *)userId
           withGoodKey:(NSString *)goodKey
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure
{
    NSString *url = @"delUserFavorite";
    NSDictionary *dic =  @{@"uid":userId,@"goodkey":goodKey};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getMessageInfo:(NSString *)userId
                    withPage:(NSInteger)page
                     success:(void (^)(id json))success
                     failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getMessageInfo";
    NSDictionary *dic =  @{@"uid":userId,@"page":@(page),@"perpage":@(PAGE_COUNT)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)delMessage:(NSArray *)msgArray
          success:(void (^)(id json))success
          failure:(void (^)( NSError *err))failure
{
    NSString *url = @"delMessage";
    NSDictionary *dic =  @{@"mid":msgArray};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}
@end
