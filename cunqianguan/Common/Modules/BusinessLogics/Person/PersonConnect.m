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

-(void)getUserFavorite:(NSString *)email
                   pwd:(NSString *)pwd
                  page:(NSInteger)page
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getUserFavorite";
    NSDictionary *dic =  @{@"email":email,@"password":pwd,@"page":@(page),@"perpage":@(PAGE_COUNT)};
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
            withTime:(NSString *)ptime
             success:(void (^)(id json))success
             failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getSignStatus";
    NSDictionary *dic =  @{@"uid":uid,@"ptime":ptime};
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

-(void)initSignStatus:(NSString *)useId
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure
{
    NSString *url = @"todaySign";
    NSDictionary *dic =  @{@"uid":useId};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getUserBankInfo:(NSString *)email
                andPwd:(NSString *)pwd
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getUserBankInfo";
    NSDictionary *dic =  @{@"email":email,@"password":pwd};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getUserExtract:(NSString *)email
               andPwd:(NSString *)pwd
            withMoney:(NSInteger)money
                 type:(NSInteger)type
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure
{
    NSString *url = @"userExtract";
    NSDictionary *dic =  @{@"email":email,@"password":pwd,@"money":@(money),@"type":@(type)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getBankList:(NSDictionary *)dic
           success:(void (^)(id json))success
           failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getBankList";
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)updateAlipay:(NSString *)email
                pwd:(NSString *)pwd
         aliaccount:(NSString *)account
            success:(void (^)(id json))success
            failure:(void (^)( NSError *err))failure
{
    NSString *url = @"updateAlipay";
    NSDictionary *dic =  @{@"email":email,@"password":pwd,@"alipay_account":account};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)updateBankAccount:(NSString *)email
                     pwd:(NSString *)pwd
             bankaccount:(NSString *)account
               consignee:(NSString *)consignee
                    area:(NSInteger)areaId
                    bank:(NSInteger)bankId
                 success:(void (^)(id json))success
                 failure:(void (^)( NSError *err))failure
{
    NSString *url = @"updateBankAccount";
    NSDictionary *dic =  @{@"email":email,@"password":pwd,@"bank_account":account,@"consignee":consignee,@"area_id":@(areaId),@"bank_id":@(bankId)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getTopArea:(NSDictionary *)dic
          success:(void (^)(id json))success
          failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getTopArea";
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getSubArea:(NSInteger)areaId
          success:(void (^)(id json))success
          failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getSubArea";
    NSDictionary *dic = @{@"id":@(areaId)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)updateAddress:(NSString *)email
                 pwd:(NSString *)pwd
           consignee:(NSString *)consignee
            location:(NSString *)location
             zipCode:(NSString *)zipCode
                  qq:(NSString *)qqCode
               phone:(NSString *)phone
             success:(void (^)(id json))success
             failure:(void (^)( NSError *err))failure
{
    NSString *url = @"updateAddress";
    NSDictionary *dic = @{@"email":email,@"password":pwd,@"consignee":consignee,@"location":location,@"zip_code":zipCode,@"qq":qqCode,@"phone":phone};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getUserInvite:(NSString *)userId
             success:(void (^)(id json))success
             failure:(void (^)( NSError *err))failure
{
    
}

-(void)responseMsg:(NSString *)username
               pws:(NSString *)password
           content:(NSString *)content
           success:(void (^)(id json))success
           failure:(void (^)( NSError *err))failure
{
    NSString *url = @"responseMsg";
    NSDictionary *dic = @{@"email":username,@"password":password,@"content":content};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
 
}
@end
