//
//  MongoConnect.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MongoConnect.h"
#import "BaseConnect.h"
@implementation MongoConnect
DEFINE_SINGLETON_FOR_CLASS(MongoConnect)

-(void)getMongoGoodsById:(NSString *)userId
            withCategory:(NSInteger)category
                 andPage:(NSInteger)pageNum
                 success:(void (^)(id json))success
                 failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getMongoGoods";
    userId = userId?userId:@"";
    NSDictionary *dic =  @{@"uid":userId,@"category":@(category),@"page":@(pageNum),@"perpage":@(PAGE_COUNT)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getCateIndexById:(NSString *)parentId
                success:(void (^)(id json))success
                failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getCateIndex";
    NSDictionary *dic =  @{@"gid":parentId};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getGoodsDetail:(NSString *)goodKey
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getGoodsDetail";
    NSDictionary *dic =  @{@"goodkey":goodKey};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}
@end
