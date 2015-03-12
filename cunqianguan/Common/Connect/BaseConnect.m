//
//  BaseConnect.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseConnect.h"
#import <AFNetworking.h>
#import "UIView+UIViewExt.h"
#import "AFHTTPRequestOperationManager+Progress.h"
#import "BMAlert.h"
#import "BaseUtil.h"
#import "Constants.h"

@implementation BaseConnect

+(void) post:(NSString*)uri Parameters:(NSDictionary *)parameters
     success:(void (^)(id json))success
     failure:(void (^)(id json))failure
connectionError:(void (^)(NSError *error))connectionError
    withView:(UIView*)view{
    [BaseConnect post:uri Parameters:parameters success:^(AFHTTPRequestOperation *operation, id json){
        if ([BaseConnect isSucceeded:json]) {
            if (success) {
                success(json);
            }
        }else{
            if (view) {
                [view hideAllHUD];
                [view showStringHUD:[json objectForKey:@"info"] second:2];
            }
            if (failure) {
                success(json);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if (connectionError) {
            connectionError(error);
        }else{
            [[BMAlert sharedBMAlert] alert:@"网络连接异常" cancle:^(DoAlertView *alertView) {
            } other:nil];
            //[[CMAlert sharedCMAlert] alert:@"网络连接错误" andInterfaceName:uri];
        }
    }];
}

+(void) post:(NSString*)uri Parameters:(NSDictionary *)parameters  success:(void (^)(id json))success failure:(void (^)(id json))failure withView:(UIView*)view{
    [BaseConnect post:uri Parameters:parameters success:success failure:failure connectionError:failure withView:view];
}

+(void) get:(NSString*)uri Parameters:(NSDictionary *)parameters  success:(void (^)(id json))success failure:(void (^)(id json))failure withView:(UIView*)view{
    [BaseConnect get:uri Parameters:parameters success:^(AFHTTPRequestOperation *operation, id json){
        if ([BaseConnect isSucceeded:json]) {
            success(json);
        }else{
            if (view) {
                [view hideAllHUD];
                [view showStringHUD:[json objectForKey:@"message"] second:2];
            }
            failure(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [[BMAlert sharedBMAlert] alert:@"网络连接异常" cancle:^(DoAlertView *alertView) {
        } other:nil];
        //[[CMAlert sharedCMAlert] alert:@"网络连接错误" andInterfaceName:uri];
    }];
}

+(void) uploadFile:(NSString*)filePath withFilename:(NSString*)filename withURL:(NSString*)urlStr Parameters:(NSDictionary *)parameters  success:(void (^)(id json))success failure:(void (^)(id json))failure withView:(UIView*)view{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",nil];
    
    NSLog(@"request url is ----------> %@, and parameters is ---------> %@",urlStr,parameters);
    [manager POST:urlStr parameters:parameters progress:NULL constructingBodyWithBlock:^(id<AFMultipartFormData> formdata){
        NSURL *url = [NSURL fileURLWithPath:filePath];
        [formdata appendPartWithFileURL:url name:filename error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject){
        if ([BaseConnect isSucceeded:responseObject]) {
            if (success) {
                success(responseObject);
                NSLog(@"success----------->%@",responseObject);
            }
        }else{
            if (view) {
                [view hideAllHUD];
                [view showStringHUD:[responseObject objectForKey:@"message"] second:2];
            }
            if (failure) {
                failure(responseObject);
                NSLog(@"failure----------->%@",responseObject);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [[BMAlert sharedBMAlert] alert:@"网络连接异常" cancle:^(DoAlertView *alertView) {
        } other:nil];
        //[[CMAlert sharedCMAlert] alert:@"网络连接错误" andInterfaceName:urlStr];
    }];
}

+(void) download:(NSString*)urlStr Parameters:(NSDictionary *)parameters filePath:(NSString*)filePath success:(void (^)(id response))success failure:(void (^)(NSError* error))failure withView:(UIView*)view{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:parameters filePath:filePath downloadProgress:NULL success:^(AFHTTPRequestOperation *operation, id response){
        if (success) {
            success(response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError* error){
        if (failure) {
            failure(error);
        }
    }];
}

+(BOOL)isSucceeded:(id)dic{
    if ([dic isKindOfClass:[NSArray class]]) {
        return YES;
    }
    NSString *resultKey = @"status";
    if (![[dic allKeys] containsObject:resultKey]) {
        return YES;
    }
    id result = dic[@"status"];
    if ([result isKindOfClass:[NSString class]]) {
        return [result isEqualToString:@"true"];
    }else if ([result isKindOfClass:[NSNumber class]] && [result intValue] <= 1){
        return [result boolValue];
    }
    return NO;
}

+(void) post:(NSString*)uri Parameters:(NSDictionary *)parameters  success:(void (^)(AFHTTPRequestOperation * o, id json))success failure:(void (^)(AFHTTPRequestOperation * o, NSError * e))failure{
    NSString* urlStr = [NSString stringWithFormat:@"%@%@",API,uri];
    /*获取App版本*/
    //NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [dic setObject:INTERFACE_VERSION forKey:@"ver"];
    [dic setObject:[BaseUtil hmac_sha1:[BaseUtil toJSONData:dic] secret:@""] forKey:@"hash"];
    
    NSLog(@"request url is ----------> %@, and parameters is ---------> %@",urlStr,dic);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        NSLog(@"success----------->%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
         NSLog(@"failure----------->%@",error);
    }];
}


+(void) postAbsolutePath:(NSString*)uri Parameters:(NSDictionary *)parameters  success:(void (^)(id json))success failure:(void (^)(NSError * e))failure{
    NSLog(@"request url is ----------> %@, and parameters is ---------> %@",uri,parameters);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [manager POST:uri parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        NSLog(@"success----------->%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
        NSLog(@"failure----------->%@",error);
    }];
}

+(void) get:(NSString*)uri Parameters:(NSDictionary *)parameters  success:(void (^)(AFHTTPRequestOperation * o, id json))success failure:(void (^)(AFHTTPRequestOperation * o, NSError * e))failure{
    NSString* urlStr = [NSString stringWithFormat:@"%@%@",API,uri];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",nil];
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}
@end
