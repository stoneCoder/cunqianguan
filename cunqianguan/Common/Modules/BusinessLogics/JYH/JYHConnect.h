//
//  JYHConnect.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYHConnect : NSObject
DEFINE_SINGLETON_FOR_HEADER(JYHConnect)

-(void)getJYHGoodsById:(NSString *)userId
           withCategory:(NSInteger)category
               andPage:(NSInteger)pageNum
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure;

-(void)getJYHGoodById:(NSString *)userId
          andGoodKey:(NSString *)goodKey
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure;

-(void)getJyhGoodsTomorrowById:(NSString *)userId
                  withCategory:(NSInteger)category
                       andPage:(NSInteger)pageNum
                       success:(void (^)(id json))success
                       failure:(void (^)( NSError *err))failure;

-(void)getTeJiaGoodsById:(NSString *)userId
                withCategory:(NSInteger)category
                 andPage:(NSInteger)pageNum
                 success:(void (^)(id json))success
                 failure:(void (^)( NSError *err))failure;
@end
