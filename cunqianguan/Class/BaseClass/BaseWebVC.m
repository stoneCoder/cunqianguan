//
//  BaseWebVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/4.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseWebVC.h"
#import "TBUrlUtil.h"
#import "BaseUtil.h"
#import "BMAlert.h"
#import "PersonInfo.h"
#import "FootConnect.h"
#import "BaseConnect.h"
#import "Constants.h"
@interface BaseWebVC ()<UIWebViewDelegate>
{
    PersonInfo *_info;
    BOOL _isAddTrance;
}

@end

@implementation BaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _info = [PersonInfo sharedPersonInfo];
    _isAddTrance = NO;
    if (self.webView == nil) {
        CGRect frame = CGRectMake(0, 0, VIEW_WIDTH, [UIScreen mainScreen].bounds.size.height);
        self.webView = [[UIWebView alloc] initWithFrame:frame];
        self.webView.delegate = self;
        [self.view addSubview:self.webView];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.webView loadHTMLString:@"" baseURL:nil];
    [self.webView stopLoading];
    [self.webView removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(navigationType == UIWebViewNavigationTypeLinkClicked){
        _isTrueTrance = YES;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showHUD:DATA_LOAD];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    __block NSString *userId = _info.userId?_info.userId:@"";
    NSString *accesUrl = webView.request.URL.absoluteString;
    if (_isTrueTrance) {
        NSInteger type = [TBUrlUtil matchUrlWithWebSite:accesUrl];
        if (type < 4) {
            __block NSString *productId = [TBUrlUtil getTBItemId:accesUrl];
//            if (type == TB_REBATE_FINAL_DETAIL_URL || type == TM_REBATE_FINAL_DETAIL_URL) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:kWebUrlFinal object:accesUrl];
//            }else{
//                [[NSNotificationCenter defaultCenter] postNotificationName:kWebUrlFinal object:nil];
//            }
            if (!_isAddTrance) {
                if (type == TB_ORI_DETAIL_URL || type == TB_REBATE_FINAL_DETAIL_URL) {
                    productId = [NSString stringWithFormat:@"0_%@",productId];
                }else if (type == TM_ORI_DETAIL_URL || type == TM_REBATE_FINAL_DETAIL_URL){
                    productId = [NSString stringWithFormat:@"999_%@",productId];
                }
                //添加足迹
                [self addTrace:userId WithProduct:productId andType:type finalUrl:accesUrl inView:webView];
            }
        }else{
            //天天特价
            if ([accesUrl rangeOfString:@"http://ai.m.taobao.com/bu.html"].location != NSNotFound && [accesUrl rangeOfString:@"&id=1"].location != NSNotFound) {
                NSString *urlStr = [NSString stringWithFormat:@"%@%@&unid=%@",MALL_TB_URL2,MM,[BaseUtil encrypt:userId]];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
            }
            //聚划算
            if ([accesUrl rangeOfString:@"http://ai.m.taobao.com/bu.html"].location != NSNotFound && [accesUrl rangeOfString:@"&id=2"].location != NSNotFound) {
                [self hideAllHUD];
                [self showStringHUD:@"聚划算/天猫超市无返利" second:1.5];
            }
            //淘宝旅行
            if ([accesUrl rangeOfString:@"http://ai.m.taobao.com/bu.html"].location != NSNotFound && [accesUrl rangeOfString:@"&id=3"].location != NSNotFound) {
                NSString *urlStr = [NSString stringWithFormat:@"%@%@&unid=%@",MALL_TB_URL3,MM,[BaseUtil encrypt:userId]];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
            }
            //天猫超市详情页面
            if ([accesUrl rangeOfString:@"http://tun.tmall.com/"].location != NSNotFound) {
                //            [[BMAlert sharedBMAlert] alert:@"聚划算/天猫超市无返利" cancle:^(DoAlertView *alertView) {
                //
                //            } other:^(DoAlertView *alertView) {
                //
                //            }];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kWebUrlFinal object:nil];
        }

    }else{
        /*本地跳转系统自动加入足迹*/
        NSInteger type = [TBUrlUtil matchUrlWithWebSite:accesUrl];
        if (type < 4) {
            [_info saveTraceFlag:@"YES"];
            if (type == TB_REBATE_FINAL_DETAIL_URL || type == TM_REBATE_FINAL_DETAIL_URL) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kWebUrlFinal object:accesUrl];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:kWebUrlFinal object:nil];
            }
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:kWebUrlFinal object:nil];
        }
    }
    [self hideAllHUD];
}

#pragma mark -- Private 添加足迹
-(void)addTrace:(NSString *)userId WithProduct:(NSString *)productId andType:(NSInteger)type finalUrl:(NSString *)accesUrl inView:(UIWebView *)webView
{
    //添加足迹
    [[FootConnect sharedFootConnect] addTrace:userId withGoodKey:productId success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            //添加足迹成功
            _isAddTrance = YES;
            [_info saveTraceFlag:@"YES"];
            if (type == TB_REBATE_FINAL_DETAIL_URL || type == TM_REBATE_FINAL_DETAIL_URL) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kWebUrlFinal object:accesUrl];
            }
        }else{
            //添加足迹失败
            //访问淘宝
            if (type == TB_ORI_DETAIL_URL || type == TB_REBATE_FINAL_DETAIL_URL) {
                [self addTaobaoTrace:userId WithProduct:productId type:type andFinalUrl:accesUrl];
            }else if (type == TM_ORI_DETAIL_URL || type == TM_REBATE_FINAL_DETAIL_URL){
                //访问天猫
                [self addTmallTrace:userId WithProduct:productId type:type andFinalUrl:accesUrl inView:webView];
            }
        }
    } failure:^(NSError *err) {
        
    }];
}

#pragma mark -- 添加淘宝足迹
-(void)addTaobaoTrace:(NSString *)userId WithProduct:(NSString *)productId type:(NSInteger)type andFinalUrl:(NSString *)accesUrl
{
    //获取淘宝产品信息
    [[FootConnect sharedFootConnect] getTaobaoProductInfo:productId success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if (dic.count > 0) {
            NSString *key = [[dic objectForKey:@"ret"][0] componentsSeparatedByString:@"::"][0];
            if ([key isEqualToString:@"SUCCESS"]) {
                NSDictionary *goodInfo = [[dic objectForKey:@"data"] objectForKey:@"itemInfoModel"];
                NSString *title = [goodInfo objectForKey:@"title"];
                NSString *pic_url = [goodInfo objectForKey:@"picsPath"][0];
                /*获取价格*/
                NSArray *data = [[dic objectForKey:@"data"] objectForKey:@"apiStack"];
                NSString *info = [data[0] objectForKey:@"value"];
                NSArray *priceInfo = [[[[BaseUtil jsonStrToDic:info] objectForKey:@"data"] objectForKey:@"itemInfoModel"] objectForKey:@"priceUnits"];
                NSString *price = [priceInfo[0] objectForKey:@"price"];
                [[FootConnect sharedFootConnect] addTrace:userId goodKey:productId title:title picUrl:pic_url price:price success:^(id json) {
                    NSDictionary *dic = (NSDictionary *)json;
                    if ([BaseConnect isSucceeded:dic]) {
                        _isAddTrance = YES;
                        [_info saveTraceFlag:@"YES"];
                        if (type == TB_REBATE_FINAL_DETAIL_URL) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:kWebUrlFinal object:accesUrl];
                        }
                    }else{
                         [[NSNotificationCenter defaultCenter] postNotificationName:kWebUrlFinal object:nil];
                    }
                } failure:^(NSError *err) {
                    
                }];
            }
        }
    } failure:^(NSError *err) {
        
    }];
}

#pragma mark -- 添加天猫足迹
-(void)addTmallTrace:(NSString *)userId WithProduct:(NSString *)productId type:(NSInteger)type andFinalUrl:(NSString *)accesUrl inView:(UIWebView *)webView
{
    NSString *price = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('ui-yen')[0].innerHTML"];
    price = [price substringFromIndex:1];
    NSString *pic_url = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('s-showcase').getElementsByTagName('img')[0].src"];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('s-title').getElementsByTagName('h1')[0].innerHTML"];
    [[FootConnect sharedFootConnect] addTrace:userId goodKey:productId title:title picUrl:pic_url price:price success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _isAddTrance = YES;
            [_info saveTraceFlag:@"YES"];
            if (type == TM_REBATE_FINAL_DETAIL_URL) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kWebUrlFinal object:accesUrl];
            }
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:kWebUrlFinal object:nil];
        }
    } failure:^(NSError *err) {
        
    }];
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
