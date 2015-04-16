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
    NSString *first;
    if ([goodKey rangeOfString:@"_"].location != NSNotFound) {
        first = [goodKey componentsSeparatedByString:@"_"][0];
        //goodKey = [goodKey componentsSeparatedByString:@"_"][1];
    }
    NSString *shareQQURL = SHARE_QQ_URL(goodKey,userId);
    NSString *shareWCURL = SHARE_WC_URL(goodKey,userId);
    NSString *shareWXURL = SHARE_WX_URL(goodKey,userId);
    NSString *shareWebText = SHARE_WB_URL(goodKey, userId);
    
    if ([first integerValue] == 1000 ) { //1000聚优惠
        shareQQURL = SHARE_QQ_JYH_URL(goodKey, userId);
        shareWCURL = SHARE_WC_JYH_URL(goodKey, userId);
        shareWXURL = SHARE_WX_JYH_URL(goodKey, userId);
        shareWebText = SHARE_WB_JYH_URL(goodKey, userId);
    }
    
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imageUrl];
    
    /*QQ*/
    //[UMSocialData defaultData].extConfig.qqData.url = shareQQURL;
    //[UMSocialData defaultData].extConfig.qqData.title = SHARE_TITLE(11.0f,11.0f);
    //[UMSocialData defaultData].extConfig.qqData.shareText = SHARE_CONTENT;
    
    [UMSocialData defaultData].extConfig.qzoneData.url = shareQQURL;
    [UMSocialData defaultData].extConfig.qzoneData.title = content;
    [UMSocialData defaultData].extConfig.qzoneData.shareText = SHARE_CONTENT;
    
    /*微信好友*/
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareWCURL;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = SHARE_WX_TITLE;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = SHARE_WX_CONTENT;
    
    /*微信朋友圈*/
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareWXURL;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = SHARE_WX_TITLE;
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = SHARE_WX_CONTENT;
    
    /*微博*/
    [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"%@%@",SHARE_CONTENT,shareWebText];
    
        //修改集成面板数据
//        UMSocialSnsPlatform *sinaPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//        sinaPlatform.snsClickHandler = ^(UIViewController *presentingController, UMSocialControllerService * socialControllerService, BOOL isPresentInController){
//            
//            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social" image:nil location:nil urlResource:nil presentedController:controller completion:^(UMSocialResponseEntity *response){
//                if (response.responseCode == UMSResponseCodeSuccess) {
//                    NSLog(@"分享成功！");
//                }
//            }];
//        };
    
    [UMSocialSnsService presentSnsIconSheetView:controller
                                         appKey:nil
                                      shareText:content
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:/*UMShareToQQ,*/UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,nil]
                                       delegate:nil];
}

+ (void)presentInviteView:(UIViewController *)controller
                  content:(NSString *)content
                  image:(UIImage *)shareImage
{
    /*QQ*/
    [UMSocialData defaultData].extConfig.qqData.title = INVITE_TITLE;
    [UMSocialData defaultData].extConfig.qqData.shareText = INVITE_CONTENT;
    [UMSocialData defaultData].extConfig.qqData.url = content;
    
    
    /*微信好友*/
    [UMSocialData defaultData].extConfig.wechatSessionData.title = INVITE_TITLE;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = INVITE_CONTENT;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = content;
    
    /*微信朋友圈*/
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = INVITE_TITLE;
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = INVITE_CONTENT;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = content;
    
    /*微博*/
    [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"%@%@",INVITE_CONTENT,content];
    
    [UMSocialSnsService presentSnsIconSheetView:controller
                                         appKey:nil
                                      shareText:content
                                     shareImage:shareImage
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,nil]
                                       delegate:nil];
}

//#pragma mark UIWebViewDelegate方法
///**
// *开始加重请求拦截
// */
//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    
//    NSString *urlstr = request.URL.absoluteString;
//    NSRange range = [urlstr rangeOfString:@"ios://"];
//    if (range.length!=0) {
//        NSString *method = [urlstr substringFromIndex:(range.location+range.length)];
//        SEL selctor = NSSelectorFromString(method);
//        [self performSelector:selctor withObject:nil];
//    }
//    return YES;
//}

+(void)shareForWxInView:(UIViewController *)controller
                content:(NSString *)content
               imageUrl:(NSString *)imageUrl
               shareUrl:(NSString *)url
                success:(void (^)(NSInteger responseCode))success
{
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imageUrl];
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:content image:nil location:nil urlResource:nil presentedController:controller completion:^(UMSocialResponseEntity *response){
        success(response.responseCode);
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

@end
