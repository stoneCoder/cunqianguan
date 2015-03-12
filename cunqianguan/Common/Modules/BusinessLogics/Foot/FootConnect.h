//
//  FootConnect.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FootConnect : NSObject
DEFINE_SINGLETON_FOR_HEADER(FootConnect)

-(void)addTrace:(NSString *)userId
    withGoodKey:(NSString *)goodKey
        success:(void (^)(id json))success
        failure:(void (^)( NSError *err))failure;

-(void)addTrace:(NSString *)userId
        goodKey:(NSString *)goodKey
          title:(NSString *)title
         picUrl:(NSString *)picUrl
          price:(NSString *)price
        success:(void (^)(id json))success
        failure:(void (^)( NSError *err))failure;

-(void)getTraceGoods:(NSString *)userId
    withPage:(NSInteger)page
        success:(void (^)(id json))success
        failure:(void (^)( NSError *err))failure;

-(void)delTrace:(NSString *)userId
             withGoodKey:(NSString *)goodKey
             success:(void (^)(id json))success
             failure:(void (^)( NSError *err))failure;

-(void)getTaobaoProductInfo:(NSString *)productId
                    success:(void (^)(id json))success
                    failure:(void (^)( NSError *err))failure;
@end
