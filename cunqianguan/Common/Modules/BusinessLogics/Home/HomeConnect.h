//
//  HomeConnect.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeConnect : NSObject
DEFINE_SINGLETON_FOR_HEADER(HomeConnect)

-(void)getIndexAdWith:(NSDictionary *)dic
              success:(void (^)(id json))success
              failure:(void (^)( NSError *err))failure;
@end
