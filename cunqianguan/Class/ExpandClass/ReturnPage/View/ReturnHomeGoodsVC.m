//
//  ReturnHomeGoodsVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/4.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ReturnHomeGoodsVC.h"

#import "MongoConnect.h"
#import "BaseConnect.h"
#import "MongoDetailModel.h"
@interface ReturnHomeGoodsVC ()<UIWebViewDelegate>
{
    MongoDetailModel *_model;
}

@end

@implementation ReturnHomeGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpWebView];
    [self loadData:_goodKey];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)setUpWebView
{
    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.webView.frame.size.height - _bottomView.frame.size.height - 64);
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
}

-(void)loadData:(NSString *)key
{
    [self showHUD:DATA_LOAD];
    [[MongoConnect sharedMongoConnect] getGoodsDetail:key success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            NSDictionary *data = [dic objectForKey:@"data"];
            _model = [[MongoDetailModel alloc] initWithDictionary:data error:nil];
            [self loadWebView:_model.fan_url];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

-(void)loadWebView:(NSString *)urlStr
{
    NSURL* url = [NSURL URLWithString:urlStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)leftBtnClicked:(id)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- WebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showHUD:DATA_LOAD];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideAllHUD];
}
@end
