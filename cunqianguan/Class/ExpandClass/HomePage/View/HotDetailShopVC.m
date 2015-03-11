//
//  HotDetailShopVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HotDetailShopVC.h"

@interface HotDetailShopVC ()

@end

@implementation HotDetailShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpWebView];
    [self loadViewWithData:_urlPath];
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
}

-(void)loadViewWithData:(NSString *)urlPath
{
    NSURL* url = [NSURL URLWithString:urlPath];
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
@end
