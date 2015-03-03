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

-(void)getUserFavorite:(NSString *)userId
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
             success:(void (^)(id json))success
             failure:(void (^)( NSError *err))failure;

-(void)signin:(NSString *)uid
             success:(void (^)(id json))success
             failure:(void (^)( NSError *err))failure;
@end
