//
//  HotDetailShopVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HotDetailShopVC.h"
#import "FootprintsVC.h"
#import "UIBarButtonItem+Badge.h"
#import "PopoverView.h"

#import "PersonInfo.h"



@interface HotDetailShopVC ()
{
    PersonInfo *_info;
    UIBarButtonItem *_footPrintItem;
    NSArray *_moreBtnArray;
    NSArray *_moreImageArray;
}

@end

@implementation HotDetailShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    [self setUpNavBar];
    [self setUpWebView];
    [self loadViewWithData:_urlPath];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshNavBar];
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
-(void)setUpNavBar
{
    //足迹按钮
    UIButton *footBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [footBtn setBackgroundImage:[UIImage imageNamed:@"jiaoya"] forState:UIControlStateNormal];
    [footBtn setBackgroundImage:[UIImage imageNamed:@"jiaoya_hover"] forState:UIControlStateHighlighted];
    [footBtn addTarget:self action:@selector(pushToFootPrint:) forControlEvents:UIControlEventTouchUpInside];
    _footPrintItem = [[UIBarButtonItem alloc] initWithCustomView:footBtn];
    //更多按钮
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"more_btn"] forState:UIControlStateNormal];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"more_btn_hover"] forState:UIControlStateHighlighted];
    [moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moreButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButtonItem.width = 15;
    
    NSArray *btnArray = @[moreButtonItem,spaceButtonItem,_footPrintItem];
    self.navigationItem.rightBarButtonItems = btnArray;
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
    CGPoint point = CGPointMake(CGRectGetWidth(btn.frame)/2 + btn.frame.origin.x, btn.frame.origin.y + btn.frame.size.height + 20);
    _moreBtnArray = @[@"刷新"];
    _moreImageArray = @[@"refresh_btn"];
    
    
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:_moreBtnArray images:_moreImageArray];
    pop.selectRowAtIndex = ^(NSInteger index){
        switch (index) {
            case 0:
                [self loadViewWithData:_urlPath];
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

- (void)leftBtnClicked:(id)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
