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
               ForUrl:(NSString *)url
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure
{
    NSDictionary *dic =  @{@"email":aAccount,@"password":pwd};
    [BaseConnect post:url Parameters:dic success:^(id json) {
    } failure:^(id json) {
    } withView:nil];
}
@end
