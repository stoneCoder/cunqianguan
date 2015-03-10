//
//  BaseConnect.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseConnect : NSObject

+(void) post:(NSString*)uri Parameters:(NSDictionary *)parameters
     success:(void (^)(id json))success
     failure:(void (^)(id json))failure
connectionError:(void (^)(NSError *error))connectionError
    withView:(UIView*)view;

+(void) post:(NSString*)uri Parameters:(NSDictionary *)parameters  success:(void (^)(id json))success failure:(void (^)(id json))failure withView:(UIView*)view;

+(void) get:(NSString*)uri Parameters:(NSDictionary *)parameters  success:(void (^)(id json))success failure:(void (^)(id json))failure withView:(UIView*)view;


/**
 *  上传文件
 *
 *  @param filePath   文件路径
 *  @param filename   文件对应字段名称
 *  @param urlStr     URL
 *  @param parameters 其它参数
 *  @param success
 *  @param failure
 *  @param view       当前view
 */
+(void) uploadFile:(NSString*)filePath withFilename:(NSString*)filename withURL:(NSString*)urlStr Parameters:(NSDictionary *)parameters  success:(void (^)(id json))success failure:(void (^)(id json))failure withView:(UIView*)view;


/**
 *  下载文件到指定路径
 *
 *  @param urlStr     网络文件URL
 *  @param parameters 参数
 *  @param filePath   本地路径
 *  @param success
 *  @param failure
 *  @param view       当前view
 */
+(void) download:(NSString*)urlStr Parameters:(NSDictionary *)parameters filePath:(NSString*)filePath success:(void (^)(id response))success failure:(void (^)(NSError* error))failure withView:(UIView*)view;


+(BOOL)isSucceeded:(NSDictionary *)dic;
@end
