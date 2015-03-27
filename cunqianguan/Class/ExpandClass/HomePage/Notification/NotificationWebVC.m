//
//  NotificationWebVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "NotificationWebVC.h"
#import "PersonInfo.h"
#import "ShareUtil.h"
#import "UMSocial.h"
#import "HomeConnect.h"
@implementation NotificationWebVC
{
    PersonInfo *_info;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    [self setUpWebView];
    [self loadViewWithData:_urlPath];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpWebView
{
    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.webView.frame.size.height);
    self.webView.scalesPageToFit = YES;
}

-(void)loadViewWithData:(NSString *)urlPath
{
    //中文URL处理办法
    urlPath = [urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:urlPath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark -- UIWebViewDelegate
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString hasPrefix:@"js-call://user/set"]) {
        NSDictionary *parameters = [self queryStringToDictionary:request.URL.absoluteString];
        [ShareUtil  shareForWxInView:self content:[parameters objectForKey:@"content"] imageUrl:[parameters objectForKey:@"picUrl"] shareUrl:[parameters objectForKey:@"url"] success:^(NSInteger responseCode) {
            if (responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
                [[HomeConnect sharedHomeConnect] getPushRead:_info.userId msgKey:[_remoteDic objectForKey:@"msgkey"] success:^(id json) {
                    /*跳转*/
                } failure:^(NSError *err) {
                    
                }];
            }
        }];
        return NO;
    }
    return YES;
}

#pragma mark -- Private
- (NSMutableDictionary*)queryStringToDictionary:(NSString*)string {
    NSMutableArray *elements = (NSMutableArray*)[string componentsSeparatedByString:@"&"];
    [elements removeObjectAtIndex:0];
    NSMutableDictionary *retval = [NSMutableDictionary dictionaryWithCapacity:[elements count]];
    for(NSString *e in elements) {
        NSArray *pair = [e componentsSeparatedByString:@"="];
        [retval setObject:[pair objectAtIndex:1] forKey:[pair objectAtIndex:0]];
    }
    return retval;
}
@end
