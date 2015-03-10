//
//  BaseWebVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/4.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseWebVC.h"
#import "TBUrlUtil.h"
#import "BMAlert.h"
@interface BaseWebVC ()<UIWebViewDelegate>

@end

@implementation BaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.webView == nil) {
        CGRect frame = CGRectMake(0, 0, VIEW_WIDTH, [UIScreen mainScreen].bounds.size.height);
        self.webView = [[UIWebView alloc] initWithFrame:frame];
        self.webView.delegate = self;
        [self.view addSubview:self.webView];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.webView loadHTMLString:@"" baseURL:nil];
    [self.webView stopLoading];
    [self.webView removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showHUD:DATA_LOAD];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *accesUrl = webView.request.URL.absoluteString;
    NSInteger type = [TBUrlUtil matchUrlWithWebSite:accesUrl];
    if (type != NOT_TB_URL) {
        NSString *productId = [TBUrlUtil getTBItemId:accesUrl];
    }else{
        //天天特价
        
        if ([accesUrl rangeOfString:@"http://ai.m.taobao.com/bu.html"].location != NSNotFound && [accesUrl rangeOfString:@"&id=1"].location != NSNotFound) {
            //            [[BMAlert sharedBMAlert] alert:@"聚划算/天猫超市无返利" cancle:^(DoAlertView *alertView) {
            //
            //            } other:^(DoAlertView *alertView) {
            //
            //            }];
        }
        //聚优惠
        if ([accesUrl rangeOfString:@"http://ai.m.taobao.com/bu.html"].location != NSNotFound && [accesUrl rangeOfString:@"&id=2"].location != NSNotFound) {
//            [[BMAlert sharedBMAlert] alert:@"聚划算/天猫超市无返利" cancle:^(DoAlertView *alertView) {
//                
//            } other:^(DoAlertView *alertView) {
//                
//            }];
        }
        //淘宝旅行
        if ([accesUrl rangeOfString:@"http://ai.m.taobao.com/bu.html"].location != NSNotFound && [accesUrl rangeOfString:@"&id=3"].location != NSNotFound) {
            //            [[BMAlert sharedBMAlert] alert:@"聚划算/天猫超市无返利" cancle:^(DoAlertView *alertView) {
            //
            //            } other:^(DoAlertView *alertView) {
            //
            //            }];
        }
        //天猫超市详情页面
        if ([accesUrl rangeOfString:@"http://tun.tmall.com/"].location != NSNotFound) {
            //            [[BMAlert sharedBMAlert] alert:@"聚划算/天猫超市无返利" cancle:^(DoAlertView *alertView) {
            //
            //            } other:^(DoAlertView *alertView) {
            //
            //            }];
        }
    }
    [self hideAllHUD];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
