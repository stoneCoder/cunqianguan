//
//  PersonConnect.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PersonConnect.h"
#import "BaseConnect.h"
#import "BaseUtil.h"

@implementation PersonConnect
DEFINE_SINGLETON_FOR_CLASS(PersonConnect)

-(void)updateAvatar:(NSString *)uid
        andFilePath:(NSString *)filePath
            success:(void (^)(id json))success
            failure:(void (^)( NSError *err))failure
{
    NSString* urlStr = [NSString stringWithFormat:@"%@updateAvatar",API];
    NSDictionary *dic = @{@"uid":uid,@"ver":INTERFACE_VERSION};
    
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:dic];
    [data setObject:[BaseUtil hmac_sha1:[BaseUtil toJSONData:dic] secret:@""] forKey:@"hash"];
  
    [BaseConnect uploadFile:filePath withFilename:@"avatar" withURL:urlStr Parameters:data success:^(id json) {
         success(json);
    } failure:^(id json) {
         failure(json);
    } withView:nil];
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
    userId = userId?userId:@"";
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

-(void)getUserMoneyInfo:(NSString *)email
                    pwd:(NSString *)pwd
               WithType:(NSInteger)type
                andPage:(NSInteger)page
                success:(void (^)(id json))success
                failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getUserMoneyInfo";
    NSDictionary *dic =  @{@"email":email,@"password":pwd,@"type":@(type),@"page":@(page),@"perpage":@(PAGE_COUNT)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getSignStatus:(NSString *)uid
             success:(void (^)(id json))success
             failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getSignStatus";
    NSDictionary *dic =  @{@"uid":uid};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)signin:(NSString *)uid
      success:(void (^)(id json))success
      failure:(void (^)( NSError *err))failure
{
    NSString *url = @"signin";
    NSDictionary *dic =  @{@"uid":uid};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}
@end
