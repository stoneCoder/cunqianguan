//
//  LoginConnect.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "LoginConnect.h"

@implementation LoginConnect
DEFINE_SINGLETON_FOR_CLASS(LoginConnect)

-(void)loginByAccount:(NSString *)aAccount
              withPwd:(NSString *)pwd
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure
{
    NSString *url = @"login";
    
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    deviceToken = deviceToken?deviceToken:@"";
    
    NSDictionary *dic =  @{@"email":aAccount,@"password":pwd,@"ios":@"YES",@"uniquekey":deviceToken};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)registByAccount:(NSString *)aAccount
              userName:(NSString *)username
               withPwd:(NSString *)pwd
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure
{
    NSString *url = @"register";
    NSDictionary *dic =  @{@"email":aAccount,@"username":username,@"password":pwd,@"ios":@"YES"};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)findPwdByAccount:(NSString *)aAccount
                success:(void (^)(id json))success
                failure:(void (^)( NSError *err))failure
{
    NSString *url = @"forgotPassword";
    NSDictionary *dic =  @{@"email":aAccount};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)getUserByOauth:(NSString *)uuid
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure
{
    NSString *url = @"getUserByOauth";
    NSDictionary *dic =  @{@"uuid":uuid};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}

-(void)bindOauth:(NSString *)email
         withPwd:(NSString *)pwd
            name:(NSString *)username
            uuid:(NSString *)uuid
            type:(NSString *)type
         success:(void (^)(id json))success
         failure:(void (^)( NSError *err))failure
{
    NSString *url = @"bindOauth";
    NSDictionary *dic =  @{@"email":email,@"password":pwd,@"uuid":uuid,@"web":type,@"webname":username};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}
@end
