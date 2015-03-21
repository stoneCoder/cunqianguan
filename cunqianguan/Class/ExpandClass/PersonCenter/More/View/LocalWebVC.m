//
//  LocalWebVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "LocalWebVC.h"

@interface LocalWebVC ()<UIWebViewDelegate>

@end

@implementation LocalWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpWebView];
    [self loadWebView];
    [self hideProgressView];
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
-(void)setUpWebView
{
    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.webView.frame.size.height - 64);
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
}

-(void)loadWebView
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"intro" ofType:@"html"];
    if (_loadType == 1) {
        filePath = [[NSBundle mainBundle] pathForResource:@"protocolfb" ofType:@"html"];
    }
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
}

#pragma mark -- UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //[self showHUD:DATA_LOAD];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideLoaderView];
    //[self hideAllHUD];
}
@end
