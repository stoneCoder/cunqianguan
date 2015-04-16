//
//  RebateHomeVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/6.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "RebateHomeVC.h"
#import "FootPrintsVC.h"
#import "UIBarButtonItem+Badge.h"
#import "PopoverView.h"

#import "BaseUtil.h"
#import "Constants.h"
#import "PersonInfo.h"
@interface RebateHomeVC ()<UIWebViewDelegate>
{
    PersonInfo *_info;
    UIBarButtonItem *_footPrintItem;
    NSArray *_moreBtnArray;
    NSArray *_moreImageArray;
}

@end

@implementation RebateHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    [self hideReturnBtn];
    [self setUpNavBar];
    [self setUpWebView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNavBar) name:kWebUrlFinal object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshNavBar];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kWebUrlFinal object:nil];
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
    //更多按钮
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"more_web"] forState:UIControlStateNormal];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"more_web_down"] forState:UIControlStateHighlighted];
    [moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moreButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButtonItem.width = 15;
    
    NSArray *btnArray = @[moreButtonItem,spaceButtonItem,_footPrintItem];
    self.navigationItem.rightBarButtonItems = btnArray;
}

-(void)setUpWebView
{
    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.webView.frame.size.height - 64);
    self.webView.scalesPageToFit = YES;
    [self refreshView];
}

-(void)refreshView
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@&unid=%@",aiTaoUrl,MM,_info.userId];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)leftBtnClicked:(id)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        if (!self.isReturnBack) {
            [self setWebViewReturnBtnTitle:self.leftTitle titleColor:UIColorFromRGB(0x3c3c3c) highlightedTileColor:UIColorFromRGB(0x000000) WithImage:@"back_web" andHighlightImage:@"back_web_down" edgeInsetsWithTitle:0];
            self.isReturnBack = YES;
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)closeAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- Private
-(void)pushToFootPrint:(id)sender
{
    [_info isLoginWithPresent:^(BOOL flag) {
        [_info saveTraceFlag:@"NO"];
        FootPrintsVC *footPrintsVC = [[FootPrintsVC alloc] init];
        footPrintsVC.leftTitle = @"足迹";
        [self.navigationController pushViewController:footPrintsVC animated:YES];
    } WithType:YES];
}

-(void)moreAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    CGPoint point = CGPointMake(CGRectGetWidth(btn.frame)/2 + btn.frame.origin.x, btn.frame.origin.y + btn.frame.size.height + 32);
     _moreBtnArray = @[@"刷新"];
    _moreImageArray = @[@"refresh_btn"];
    
    
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:_moreBtnArray images:_moreImageArray];
    pop.layer.cornerRadius = 5.0f;
    pop.layer.masksToBounds = YES;
    pop.selectRowAtIndex = ^(NSInteger index){
            switch (index) {
                case 0:
                    [self refreshView];
                    break;
            }
    };
  
    [pop show];
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
