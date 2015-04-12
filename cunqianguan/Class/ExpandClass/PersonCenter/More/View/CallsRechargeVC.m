//
//  CallsRechargeVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "CallsRechargeVC.h"
#import "FootPrintsVC.h"
#import "UIBarButtonItem+Badge.h"
#import "PersonInfo.h"
#import "Constants.h"
@interface CallsRechargeVC ()
{
    PersonInfo *_info;
    UIBarButtonItem *_footPrintItem;
}

@end

@implementation CallsRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    [self setUpNavBar];
    [self setUpWebView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshNavBar];
}

-(void)setUpNavBar
{
    [self setReturnBtnTitle:self.leftTitle titleColor:UIColorFromRGB(0x3c3c3c) highlightedTileColor:UIColorFromRGB(0x000000) WithImage:@"back_web" andHighlightImage:@"back_web_down" edgeInsetsWithTitle:0];
    //足迹按钮
    UIButton *footBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [footBtn setBackgroundImage:[UIImage imageNamed:@"foot_web"] forState:UIControlStateNormal];
    [footBtn setBackgroundImage:[UIImage imageNamed:@"foot_web_down"] forState:UIControlStateHighlighted];
    [footBtn addTarget:self action:@selector(pushToFootPrint:) forControlEvents:UIControlEventTouchUpInside];
    _footPrintItem = [[UIBarButtonItem alloc] initWithCustomView:footBtn];
    NSArray *btnArray = @[_footPrintItem];
    self.navigationItem.rightBarButtonItems = btnArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpWebView
{
    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.webView.frame.size.height - 64);
    self.webView.scalesPageToFit = YES;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@&backHiddenFlag=1&unid=%@",CallS_RECHARGE_URL,MM,_info.userId];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)leftBtnClicked:(id)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        if (!self.isReturnBack) {
            [self setWebViewReturnBtnTitle:@"淘宝" titleColor:UIColorFromRGB(0x3c3c3c) highlightedTileColor:UIColorFromRGB(0x000000) WithImage:@"back_web" andHighlightImage:@"back_web_down" edgeInsetsWithTitle:0];
            self.isReturnBack = YES;
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)pushToFootPrint:(id)sender
{
    [_info isLoginWithPresent:^(BOOL flag) {
        [_info saveTraceFlag:@"NO"];
        FootPrintsVC *footPrintsVC = [[FootPrintsVC alloc] init];
        footPrintsVC.leftTitle = @"足迹";
        [self.navigationController pushViewController:footPrintsVC animated:YES];
    } WithType:YES];
}

-(void)refreshNavBar
{
    if ([_info isNewTrace]) {
        _footPrintItem.badgeValue = @" ";
    }else{
        _footPrintItem.badgeValue = @"";
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

@end
