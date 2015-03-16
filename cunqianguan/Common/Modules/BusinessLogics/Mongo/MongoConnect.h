//
//  MongoConnect.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MongoConnect : NSObject
DEFINE_SINGLETON_FOR_HEADER(MongoConnect)

-(void)getMongoGoodsById:(NSString *)userId
            withCategory:(NSInteger)category
                 andPage:(NSInteger)pageNum
                 success:(void (^)(id json))success
                 failure:(void (^)( NSError *err))failure;

-(void)getCateIndexById:(NSString *)parentId
                success:(void (^)(id json))success
                failure:(void (^)( NSError *err))failure;

-(void)getGoodsDetail:(NSString *)goodKey
           WithUserId:(NSString *)userId
                  success:(void (^)(id json))success
                  failure:(void (^)( NSError *err))failure;
@end
