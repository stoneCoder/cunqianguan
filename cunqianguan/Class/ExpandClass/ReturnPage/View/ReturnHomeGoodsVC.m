//
//  ReturnHomeGoodsVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/4.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ReturnHomeGoodsVC.h"

@interface ReturnHomeGoodsVC ()

@end

@implementation ReturnHomeGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpWebView];
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
    self.webView.frame = CGRectMake(0, 0, VIEW_WIDTH, self.webView.frame.size.height - _bottomView.frame.size.height - 64);
    self.webView.scalesPageToFit = YES;
    NSURL* url = [NSURL URLWithString:@"http://www.youku.com"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
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
