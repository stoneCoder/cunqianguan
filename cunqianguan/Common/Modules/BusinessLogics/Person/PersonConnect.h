//
//  PersonConnect.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonConnect : NSObject
DEFINE_SINGLETON_FOR_HEADER(PersonConnect)

-(void)updateAvatar:(NSString *)uid
        andFilePath:(NSString *)filePath
            success:(void (^)(id json))success
            failure:(void (^)( NSError *err))failure;


-(void)getOrderInfo:(NSString *)email
                pwd:(NSString *)pwd
           withType:(NSInteger)type
            andPage:(NSInteger)page
            success:(void (^)(id json))success
            failure:(void (^)( NSError *err))failure;

-(void)getUserFavorite:(NSString *)email
                   pwd:(NSString *)pwd
                  page:(NSInteger)page
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure;

-(void)addUserFavorite:(NSString *)userId
           withGoodKey:(NSString *)goodKey
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure;

-(void)delUserFavorite:(NSString *)userId
           withGoodKey:(NSString *)goodKey
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure;

-(void)getMessageInfo:(NSString *)userId
             withPage:(NSInteger)page
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure;

-(void)delMessage:(NSArray *)msgArray
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure;

-(void)getUserMoneyInfo:(NSString *)email
                pwd:(NSString *)pwd
                WithType:(NSInteger)type
                andPage:(NSInteger)page
                success:(void (^)(id json))success
                failure:(void (^)( NSError *err))failure;

-(void)getSignStatus:(NSString *)uid
            withTime:(NSString *)ptime
             success:(void (^)(id json))success
             failure:(void (^)( NSError *err))failure;

-(void)signin:(NSString *)uid
             success:(void (^)(id json))success
             failure:(void (^)( NSError *err))failure;

-(void)initSignStatus:(NSString *)useId
         success:(void (^)(id json))success
         failure:(void (^)( NSError *err))failure;


-(void)getUserBankInfo:(NSString *)email
                andPwd:(NSString *)pwd
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure;

-(void)getUserExtract:(NSString *)email
               andPwd:(NSString *)pwd
            withMoney:(NSInteger)money
                 type:(NSInteger)type
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure;

-(void)getBankList:(NSDictionary *)dic
           success:(void (^)(id json))success
           failure:(void (^)( NSError *err))failure;

-(void)updateAlipay:(NSString *)email
                pwd:(NSString *)pwd
         aliaccount:(NSString *)account
            success:(void (^)(id json))success
            failure:(void (^)( NSError *err))failure;

-(void)updateBankAccount:(NSString *)email
                pwd:(NSString *)pwd
         bankaccount:(NSString *)account
               consignee:(NSString *)consignee
                    area:(NSInteger)areaId
                    bank:(NSInteger)bankId
            success:(void (^)(id json))success
            failure:(void (^)( NSError *err))failure;

-(void)getTopArea:(NSDictionary *)dic
          success:(void (^)(id json))success
          failure:(void (^)( NSError *err))failure;

-(void)getSubArea:(NSInteger)areaId
          success:(void (^)(id json))success
          failure:(void (^)( NSError *err))failure;

-(void)updateAddress:(NSString *)email
                 pwd:(NSString *)pwd
           consignee:(NSString *)consignee
            location:(NSString *)location
             zipCode:(NSString *)zipCode
                  qq:(NSString *)qqCode
               phone:(NSString *)phone
             success:(void (^)(id json))success
             failure:(void (^)( NSError *err))failure;

@end
