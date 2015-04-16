//
//  JYHConnect.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JYHConnect.h"
#import "BaseConnect.h"

@implementation JYHConnect
DEFINE_SINGLETON_FOR_CLASS(JYHConnect)

-(void)getJYHGoodsById:(NSString *)userId
          withCategory:(NSInteger)category
               andPage:(NSInteger)pageNum
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getJYHGoods";
    userId = userId?userId:@"";
    NSDictionary *dic =  @{@"uid":userId,@"category":@(category),@"page":@(pageNum),@"perpage":@(PAGE_COUNT)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getJYHGoodById:(NSString *)userId
           andGoodKey:(NSString *)goodKey
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getJyhGood";
    userId = userId?userId:@"";
    NSDictionary *dic =  @{@"uid":userId,@"goodkey":goodKey};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getJyhGoodsTomorrowById:(NSString *)userId
                  withCategory:(NSInteger)category
                       andPage:(NSInteger)pageNum
                       success:(void (^)(id json))success
                       failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getJyhGoodsTomorrow";
    userId = userId?userId:@"";
    NSDictionary *dic =  @{@"uid":userId,@"category":@(category),@"page":@(pageNum),@"perpage":@(PAGE_COUNT)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getTeJiaGoodsById:(NSString *)userId
            withCategory:(NSInteger)category
                 andPage:(NSInteger)pageNum
                 success:(void (^)(id json))success
                 failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getTeJiaGoodsById";
    userId = userId?userId:@"";
    NSDictionary *dic =  @{@"uid":userId,@"cid":@(category),@"page":@(pageNum),@"perpage":@(PAGE_COUNT)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getTaoLinkById:(NSString *)userId
          withGoodKey:(NSString *)goodKey
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getTaoLink";
    NSDictionary *dic =  @{@"uid":userId,@"goodkey":goodKey};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}
@end
