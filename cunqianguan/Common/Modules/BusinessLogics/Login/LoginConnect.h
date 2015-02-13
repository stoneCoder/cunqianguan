//
//  LoginConnect.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseConnect.h"
@interface LoginConnect : NSObject
DEFINE_SINGLETON_FOR_HEADER(LoginConnect)

-(void)loginByAccount:(NSString *)aAccount
              withPwd:(NSString *)pwd
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure;

-(void)registByAccount:(NSString *)aAccount
              userName:(NSString *)username
              withPwd:(NSString *)pwd
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure;

-(void)findPwdByAccount:(NSString *)aAccount
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure;

-(void)getUserByOauth:(NSString *)uuid
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure;

-(void)bindOauth:(NSString *)email
         withPwd:(NSString *)pwd
            name:(NSString *)username
            uuid:(NSString *)uuid
            type:(NSString *)type
         success:(void (^)(id json))success
         failure:(void (^)( NSError *err))failure;

@end
