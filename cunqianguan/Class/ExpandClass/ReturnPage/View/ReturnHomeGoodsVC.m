//
//  ReturnHomeGoodsVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/4.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ReturnHomeGoodsVC.h"
#import "FootPrintsVC.h"
#import "PopoverView.h"
#import "UIBarButtonItem+Badge.h"

#import "PersonInfo.h"
#import "MongoConnect.h"
#import "BaseConnect.h"
#import "MongoDetailModel.h"
#import "PersonConnect.h"

#import "BaseUtil.h"
#import "TBUrlUtil.h"
#import "ShareUtil.h"
@interface ReturnHomeGoodsVC ()
{
    PersonInfo *_info;
    MongoDetailModel *_model;
    UIBarButtonItem *_footPrintItem;
    NSArray *_moreBtnArray;
}

@end

@implementation ReturnHomeGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    [self setUpNavBar];
    [self setUpWebView];
    [self loadData:_goodKey];
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([_info isNewTrace]) {
        _footPrintItem.badgeValue = @" ";
    }else{
        _footPrintItem.badgeValue = @"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

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
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"taobao_btn"] forState:UIControlStateNormal];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"taobao_btn_hover"] forState:UIControlStateHighlighted];
    [moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moreButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButtonItem.width = 15;
    
    NSArray *btnArray = @[moreButtonItem,spaceButtonItem,_footPrintItem];
    self.navigationItem.rightBarButtonItems = btnArray;
}

-(void)setUpWebView
{
    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.webView.frame.size.height - _bottomView.frame.size.height - 64);
    self.webView.scalesPageToFit = YES;
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
    if ([BaseUtil isInstallApp:@"taobao://"]) {
        _moreBtnArray = @[@"刷新",@"用淘宝客户端打开",@"收藏",@"分享"];
    }else{
        _moreBtnArray = @[@"刷新",@"收藏",@"分享"];
    }
    
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:_moreBtnArray images:nil];
    pop.selectRowAtIndex = ^(NSInteger index){
        if ([BaseUtil isInstallApp:@"taobao://"]) {
            switch (index) {
                case 0:
                    [self loadData:_goodKey];
                    break;
                case 2:
                    [self addCollectInfo];
                    break;
                case 3:
                    [self shareProduct];
                    break;
            }
        }else{
            switch (index) {
                case 0:
                    [self loadData:_goodKey];
                    break;
                case 1:
                    [self addCollectInfo];
                    break;
                case 2:
                    [self shareProduct];
                    break;
            }
        }
    };
    [pop show];
}


#pragma mark -- Private
-(void)addCollectInfo
{
    [self showHUD:ACTION_LOAD];
    [[PersonConnect sharedPersonConnect] addUserFavorite:_info.userId withGoodKey:_goodKey  success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        __block NSString *resultStr = [dic objectForKey:@"info"];
        if ([BaseConnect isSucceeded:dic]) {
            [_info getUserInfo:_info.username withPwd:_info.password success:^(id json) {
                NSDictionary *dic = (NSDictionary *)json;
                if ([BaseConnect isSucceeded:dic]) {
                    [self showStringHUD:resultStr second:1.5];
                }
            } failure:^(id json) {
                
            }];
        }else{
            [self showStringHUD:@"收藏失败，请重试" second:1.5];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

-(void)shareProduct
{
    [ShareUtil presentShareView:self content:@"" imageUrl:@"" goodKey:_goodKey andUserId:_info.userId];
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
