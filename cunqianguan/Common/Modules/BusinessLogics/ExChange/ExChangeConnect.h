//
//  ExChangeConnect.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExChangeConnect : NSObject
DEFINE_SINGLETON_FOR_HEADER(ExChangeConnect)

-(void)getExchangeList:(NSString *)userId
              WithAble:(NSInteger)able
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure;

-(void)exchangeGoodsDetail:(NSString *)productId
                   success:(void (^)(id json))success
                   failure:(void (^)( NSError *err))failure;

-(void)exchangeGood:(NSString *)username
                pwd:(NSString *)password
          productId:(NSString *)productId
              phone:(NSString *)phone
                 qq:(NSString *)qq
            success:(void (^)(id json))success
            failure:(void (^)( NSError *err))failure;
@end
