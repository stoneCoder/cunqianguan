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
#import "ReturnPageTipView.h"

#import "PersonInfo.h"
#import "MongoConnect.h"
#import "BaseConnect.h"
#import "MongoDetailModel.h"
#import "PersonConnect.h"

#import "Constants.h"
#import "BaseUtil.h"
#import "TBUrlUtil.h"
#import "ShareUtil.h"
@interface ReturnHomeGoodsVC ()<ReturnPageTipViewDelegate>
{
    ReturnPageTipView *_returnPageTipView;
    PersonInfo *_info;
    MongoDetailModel *_model;
    UIBarButtonItem *_footPrintItem;
    NSArray *_moreBtnArray;
    NSArray *_moreImageArray;
    NSInteger _isFav;
    NSString *_finalUrl;
}

@end

@implementation ReturnHomeGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    [self setUpTipView];
    [self setUpWebView];
    [self loadData:_goodKey];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpNavBar:) name:kWebUrlFinal object:nil];
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"showflgTips"] boolValue] && _type == 1) {
        //显示提示
        [UIView animateWithDuration:1.0f animations:^{
            _returnPageTipView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
        } completion:^(BOOL finished) {
            
        }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kWebUrlFinal object:nil];
}

-(void)setUpNavBar:(NSNotification *)notification
{
    if (notification) {
        _finalUrl = notification.object;
        if (!_finalUrl) {
            _finalUrl = _model.fan_url;
        }
    }
    //足迹按钮
    UIButton *footBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [footBtn setBackgroundImage:[UIImage imageNamed:@"jiaoya"] forState:UIControlStateNormal];
    [footBtn setBackgroundImage:[UIImage imageNamed:@"jiaoya_hover"] forState:UIControlStateHighlighted];
    [footBtn addTarget:self action:@selector(pushToFootPrint:) forControlEvents:UIControlEventTouchUpInside];
    _footPrintItem = [[UIBarButtonItem alloc] initWithCustomView:footBtn];
    [self refreshNavBar];
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

-(void)setUpTipView
{
    _returnPageTipView = [ReturnPageTipView tipView];
    _returnPageTipView.backgroundColor = UIColorFromRGBA(0x00000, 0.1);
    _returnPageTipView.delegate = self;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"fanli_tishi" ofType:@"png"];
    _returnPageTipView.tipImageView.image = [UIImage imageWithContentsOfFile:filePath];
    _returnPageTipView.frame = CGRectMake(0, SCREEN_HEIGTH, VIEW_WIDTH, VIEW_HEIGHT);
    [self.view addSubview:_returnPageTipView];
}

-(void)setUpWebView
{
    self.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.webView.frame.size.height - _bottomView.frame.size.height - 64);
    self.webView.scalesPageToFit = YES;
}

-(void)loadData:(NSString *)key
{
    [self showHUD:DATA_LOAD];
    [[MongoConnect sharedMongoConnect] getGoodsDetail:key WithUserId:_info.userId success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            NSDictionary *data = [dic objectForKey:@"data"];
            _model = [[MongoDetailModel alloc] initWithDictionary:data error:nil];
            _isFav = _model.isfav;
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

#pragma mark -- ReturnPageTipViewDelegate
-(void)clickAction
{
    [UIView animateWithDuration:1.0f animations:^{
        _returnPageTipView.frame = CGRectMake(0, VIEW_HEIGHT, VIEW_WIDTH, VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"showflgTips"];
    }];
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
    NSString *collectImageName = @"shoucang_btn";
    if (_isFav == 1) {
        collectImageName = @"shoucang_hover";
    }
    NSInteger type = [TBUrlUtil matchUrlWithWebSite:_finalUrl];
    if ([BaseUtil isInstallApp:@"taobao://"] && (type == TB_REBATE_FINAL_DETAIL_URL || type == TM_REBATE_FINAL_DETAIL_URL)) {
        _moreBtnArray = @[@"刷新",@"淘宝App打开",@"收藏",@"分享"];
        _moreImageArray = @[@"refresh_btn",@"tao_btn",collectImageName,@"share_btn"];
    }else{
        _moreBtnArray = @[@"刷新",@"收藏",@"分享"];
        _moreImageArray = @[@"refresh_btn",collectImageName,@"share_btn"];
    }
    
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:_moreBtnArray images:_moreImageArray];
    pop.selectRowAtIndex = ^(NSInteger index){
        if ([BaseUtil isInstallApp:@"taobao://"]) {
            switch (index) {
                case 0:
                    [self loadData:_goodKey];
                    break;
                case 1:
                    [self pushToOtherApp];
                    break;
                case 2:
                    [self addCollectInfo:_isFav];
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
                    [self addCollectInfo:_isFav];
                    break;
                case 2:
                    [self shareProduct];
                    break;
            }
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


#pragma mark -- Private
-(void)addCollectInfo:(NSInteger)type
{
    [self showHUD:ACTION_LOAD];
    if (type == 0) {
        /*添加收藏*/
        [[PersonConnect sharedPersonConnect] addUserFavorite:_info.userId withGoodKey:_goodKey  success:^(id json) {
            [self hideAllHUD];
            NSDictionary *dic = (NSDictionary *)json;
            if ([BaseConnect isSucceeded:dic]) {
                [_info getUserInfo:_info.username withPwd:_info.password success:^(id json) {
                    NSDictionary *dic = (NSDictionary *)json;
                    if ([BaseConnect isSucceeded:dic]) {
                        _isFav = 1;
                        [self showStringHUD:@"收藏成功" second:1.5];
                    }
                } failure:^(id json) {
                    
                }];
            }else{
                [self showStringHUD:@"收藏失败，请重试" second:1.5];
            }
        } failure:^(NSError *err) {
            [self hideAllHUD];
        }];
    }else{
       /*取消收藏*/
        [[PersonConnect sharedPersonConnect] delUserFavorite:_info.userId withGoodKey:_goodKey  success:^(id json) {
            [self hideAllHUD];
            NSDictionary *dic = (NSDictionary *)json;
            if ([BaseConnect isSucceeded:dic]) {
                [_info getUserInfo:_info.username withPwd:_info.password success:^(id json) {
                    NSDictionary *dic = (NSDictionary *)json;
                    if ([BaseConnect isSucceeded:dic]) {
                        _isFav = 0;
                        [self showStringHUD:@"取消收藏成功" second:1.5];
                    }
                } failure:^(id json) {
                    
                }];
            }else{
                [self showStringHUD:@"取消收藏失败，请重试" second:1.5];
            }
        } failure:^(NSError *err) {
            [self hideAllHUD];
        }];
    }
}

-(void)shareProduct
{
    NSString *shareContent = SHARE_CONTEXT(_model.price);
    [ShareUtil presentShareView:self content:shareContent imageUrl:_model.pic_url goodKey:_goodKey andUserId:[BaseUtil encrypt:_info.userId]];
}

-(void)pushToOtherApp
{
    if(_finalUrl){
        NSString *openUrl = [NSString stringWithFormat:@"taobao://%@",[_finalUrl componentsSeparatedByString:@"://"][1]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
    }else{
        [self showStringHUD:@"商品获取失败" second:1.5];
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
