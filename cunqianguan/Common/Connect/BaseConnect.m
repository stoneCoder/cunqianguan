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
#import "CMAlert.h"

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
                [view showStringHUD:[json objectForKey:@"message"] second:2];
            }
            if (failure) {
                failure(json);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if (connectionError) {
            connectionError(error);
        }else{
            [[CMAlert sharedCMAlert] alert:@"网络连接错误" andInterfaceName:uri];
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
        [[CMAlert sharedCMAlert] alert:@"网络连接错误" andInterfaceName:uri];
    }];
}

+(void) uploadFile:(NSString*)filePath withFilename:(NSString*)filename withURL:(NSString*)urlStr Parameters:(NSDictionary *)parameters  success:(void (^)(id json))success failure:(void (^)(id json))failure withView:(UIView*)view{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",nil];
    
    [manager POST:urlStr parameters:parameters progress:NULL constructingBodyWithBlock:^(id<AFMultipartFormData> formdata){
        NSURL *url = [NSURL fileURLWithPath:filePath];
        [formdata appendPartWithFileURL:url name:filename error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject){
        if ([BaseConnect isSucceeded:responseObject]) {
            if (success) {
                success(responseObject);
            }
        }else{
            if (view) {
                [view hideAllHUD];
                [view showStringHUD:[responseObject objectForKey:@"message"] second:2];
            }
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [[CMAlert sharedCMAlert] alert:@"网络连接错误" andInterfaceName:urlStr];
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
    NSString *resultKey = @"showMsg";
    if (![[dic allKeys] containsObject:resultKey]) {
        return YES;
    }
    id result = dic[@"showMsg"];
    if ([result isKindOfClass:[NSString class]]) {
        return [result isEqualToString:@"true"];
    }else if ([result isKindOfClass:[NSNumber class]]){
        return [result boolValue];
    }
    return NO;
}

+(void) post:(NSString*)uri Parameters:(NSDictionary *)parameters  success:(void (^)(AFHTTPRequestOperation * o, id json))success failure:(void (^)(AFHTTPRequestOperation * o, NSError * e))failure{
    NSString* urlStr = uri;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/xml", nil];
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}
+(void) get:(NSString*)uri Parameters:(NSDictionary *)parameters  success:(void (^)(AFHTTPRequestOperation * o, id json))success failure:(void (^)(AFHTTPRequestOperation * o, NSError * e))failure{
    NSString* urlStr = uri;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",nil];
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}
@end
