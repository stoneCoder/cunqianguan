//
//  ShareUtil.m
//  cunqianguan
//
//  Created by 张 磊 on 15-3-11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ShareUtil.h"
#import "UMSocial.h"

@implementation ShareUtil
DEFINE_SINGLETON_FOR_CLASS(ShareUtil)

+ (void)presentShareView:(UIViewController *)controller
                 content:(NSString *)content
                imageUrl:(NSString *)imageUrl
                 goodKey:(NSString *)goodKey
               andUserId:(NSString *)userId
{
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imageUrl];
    [UMSocialData defaultData].extConfig.qqData.url = SHARE_QQ_URL(goodKey,userId);
    [UMSocialData defaultData].extConfig.wechatSessionData.url = SHARE_WC_URL(goodKey,userId);
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = SHARE_QQ_URL(goodKey,userId);
    
    
    //修改集成面板数据
    //    UMSocialSnsPlatform *sinaPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    //    sinaPlatform.bigImageName = @"icon";
    //    sinaPlatform.displayName = @"哇哈哈";
    //    sinaPlatform.snsClickHandler = ^(UIViewController *presentingController, UMSocialControllerService * socialControllerService, BOOL isPresentInController){
    //        NSLog(@"点击新浪微博的响应");
    //    };
    
    [UMSocialSnsService presentSnsIconSheetView:controller
                                         appKey:nil
                                      shareText:content
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToQzone,UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToTencent,nil]
                                       delegate:nil];
}

+ (void)presentInviteView:(UIViewController *)controller
                  content:(NSString *)content
                 imageUrl:(NSString *)imageUrl
{
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imageUrl];
    
    [UMSocialSnsService presentSnsIconSheetView:controller
                                         appKey:nil
                                      shareText:content
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToWechatSession,UMShareToSina,nil]
                                       delegate:nil];
}

@end
