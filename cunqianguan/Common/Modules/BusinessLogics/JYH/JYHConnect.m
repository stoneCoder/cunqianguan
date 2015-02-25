//
//  JYHConnect.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/25.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "JYHConnect.h"
#import "BaseConnect.h"

@implementation JYHConnect
DEFINE_SINGLETON_FOR_CLASS(JYHConnect)

-(void)getJYHGoodsById:(NSString *)userId
          withCategory:(NSInteger)category
               andPage:(NSInteger)pageNum
               success:(void (^)(id json))success
               failure:(void (^)( NSError *err))failure;
{
    NSString *url = @"getJYHGoods";
    userId = userId?userId:@"";
    NSDictionary *dic =  @{@"uid":userId,@"category":@(category),@"page":@(pageNum),@"perpage":@(PAGE_COUNT)};
    [BaseConnect post:url Parameters:dic success:^(id json) {
        success(json);
    } failure:^(id json) {
        failure(json);
    } withView:nil];
}
@end
