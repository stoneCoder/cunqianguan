//
//  ChangeRootVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ChangeRootVC.h"
#import "ChangeProductVC.h"
#import "AddressManagerVC.h"
#import "BMAlert.h"
#import "DoAlertView.h"

#import "ExChangeConnect.h"
#import "BaseConnect.h"

#import "ExChangeDetailModel.h"
#import "PersonInfo.h"
#import "Constants.h"
#import "BaseUtil.h"
@interface ChangeRootVC ()
{
    ChangeProductVC *_changeProductVC;
    PersonInfo *_info;
}

@end

@implementation ChangeRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    [self setUpTableView];
    [self loadData:_model.productId];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTips) name:kExChangeSuccess object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kExChangeSuccess object:nil];
}

-(void)setUpTableView
{
    //_bottomView.layer.shadowOpacity = 0.1;
    _changeProductVC = [[ChangeProductVC alloc] init];
    [self addChildViewController:_changeProductVC];
    [self.view insertSubview:_changeProductVC.view belowSubview:_bottomView];
}

-(void)loadData:(NSString *)productId
{
    [self showHUD:DATA_LOAD];
    [[ExChangeConnect sharedExChangeConnect] exchangeGoodsDetail:productId success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            NSDictionary *data = [dic objectForKey:@"data"];
            ExChangeDetailModel *detailModel = [[ExChangeDetailModel alloc] initWithDictionary:data error:nil];
            [_changeProductVC reloadView:_model andDetail:detailModel];
            [self refreshBottomView];
            _infoLabel.text = [NSString stringWithFormat:@"剩余%ld件",(long)_model.in_stock];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

-(void)refreshBottomView
{
    NSInteger inSock = _model.in_stock;
    _actionBtn.layer.cornerRadius = 5.0f;
    _actionBtn.layer.masksToBounds = YES;
    if (inSock == 0) {
        [_actionBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xed4142)] forState:UIControlStateNormal];
        [_actionBtn setTitle:@"抢光了" forState:UIControlStateNormal];
        _actionBtn.userInteractionEnabled = NO;
    }else if (!_isCanChange){
        [_actionBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xb4b4b4)] forState:UIControlStateNormal];
        [_actionBtn setTitle:@"积分不足" forState:UIControlStateNormal];
        _actionBtn.userInteractionEnabled = NO;
    }else{
        /*我要兑换*/
        [_actionBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x2db8ad)] forState:UIControlStateNormal];
        [_actionBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x179a90)] forState:UIControlStateHighlighted];
    }

//    [_info getUserInfo:_info.username withPwd:_info.password success:^(id json) {
//        NSDictionary *dic = (NSDictionary *)json;
//        if ([BaseConnect isSucceeded:dic]) {
//            
//        }
//    } failure:^(id json) {
//        
//    }];
}
- (IBAction)exChangeProduct:(id)sender
{
    //真实货物
    if (_model.use_types == 0) {
        AddressManagerVC *addressManagerVC = [[AddressManagerVC alloc] init];
        addressManagerVC.leftTitle = @"收货地址";
        addressManagerVC.isExChange = YES;
        addressManagerVC.productId = _model.productId;
        [self.navigationController pushViewController:addressManagerVC animated:YES];
    }else{
    //虚拟货物
        [[BMAlert sharedBMAlert] alertTextFieldWithplaceholder:@"请输入所要兑换的手机号码" Cancle:^(DoAlertView *alertView) {
            NSString *phone = alertView.textField.text;
            if(phone.length > 0){
                [self showHUD:ACTION_LOAD];
                [[ExChangeConnect sharedExChangeConnect] exchangeGood:_info.username pwd:_info.password productId:_model.productId phone:phone qq:@"" success:^(id json) {
                    [self hideAllHUD];
                    NSDictionary *dic = (NSDictionary *)json;
                    if ([BaseConnect isSucceeded:dic]) {
                        [self showStringHUD:@"兑换成功" second:1.5];
                    }else{
                        [self showStringHUD:[dic objectForKey:@"info"] second:1.5];
                    }
                } failure:^(NSError *err) {
                    [self hideAllHUD];
                }];
            }
        } other:^(DoAlertView *alertView) {
            
        }];
    }
}

-(void)showTips
{
    [self showStringHUD:@"兑换成功" second:1.5];
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
