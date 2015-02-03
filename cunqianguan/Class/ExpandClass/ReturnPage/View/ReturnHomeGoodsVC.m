//
//  ReturnHomeGoodsVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/3.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ReturnHomeGoodsVC.h"

@interface ReturnHomeGoodsVC ()
{
    UIWebView *_webView;
}

@end

@implementation ReturnHomeGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _bottomView.layer.shadowOpacity = 0.1;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    _webView.scalesPageToFit = YES;
    
    [self.view insertSubview:_webView belowSubview:_bottomView];
    
    NSURL* url = [NSURL URLWithString:@"http://www.youku.com"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    [_webView removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
