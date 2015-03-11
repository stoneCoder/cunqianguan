//
//  ShareUtil.h
//  cunqianguan
//
//  Created by 张 磊 on 15-3-11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareUtil : NSObject
DEFINE_SINGLETON_FOR_HEADER(ShareUtil)
+ (void)presentShareView:(UIViewController *)controller
                 content:(NSString *)content
                 imageUrl:(NSString *)imageUrl
                 goodKey:(NSString *)goodKey
               andUserId:(NSString *)userId;

+ (void)presentInviteView:(UIViewController *)controller
                 content:(NSString *)content
                 imageUrl:(NSString *)imageUrl;
@end
