//
//  MoneyViewVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MoneyViewVC.h"
#import "AliTransfersView.h"
#import "BankTransfersView.h"
#import "ExChangeScrollVC.h"
#import "BMAlert.h"

#import "BaseUtil.h"
#import "PersonInfo.h"
@interface MoneyViewVC ()
{
    AliTransfersView *_aliTransfersView;
    BankTransfersView *_bankTransfersView;
    PersonInfo *_info;
}

@end

@implementation MoneyViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self refreshViewWithType:_type];
    [self setUpBtn];
    [self createAliView];
    [self createBankView];
}

-(void)setUpBtn
{
    /*去兑换商品*/
    [_integralBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x2db8ad)] forState:UIControlStateNormal];
    [_integralBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x179a90)] forState:UIControlStateHighlighted];
    _integralBtn.layer.cornerRadius = 5.0f;
    _integralBtn.layer.masksToBounds = YES;
    
    /*转到支付宝*/
    [_taoBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x2db8ad)] forState:UIControlStateNormal];
    [_taoBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x179a90)] forState:UIControlStateHighlighted];
    _taoBtn.layer.cornerRadius = 5.0f;
    _taoBtn.layer.masksToBounds = YES;
    
    /*提现到支付宝*/
    [_withdrawTaoBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x2db8ad)] forState:UIControlStateNormal];
    [_withdrawTaoBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x179a90)] forState:UIControlStateHighlighted];
    _withdrawTaoBtn.layer.cornerRadius = 5.0f;
    _withdrawTaoBtn.layer.masksToBounds = YES;
    
    /*提现到银行卡*/
    [_withdrawBankBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xed4142)] forState:UIControlStateNormal];
    [_withdrawBankBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xd22223)] forState:UIControlStateHighlighted];
    _withdrawBankBtn.layer.cornerRadius = 5.0f;
    _withdrawBankBtn.layer.masksToBounds = YES;
}

-(void)createAliView
{
    if (!_aliTransfersView) {
        _aliTransfersView = [AliTransfersView transfersView];
        [self.view addSubview:_aliTransfersView];
    }
}

-(void)createBankView
{
    if (!_bankTransfersView) {
        _bankTransfersView = [BankTransfersView transfersView];
        [self.view addSubview:_bankTransfersView];
    }
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

#pragma mark -- Private
-(void)refreshViewWithType:(ViewType)viewType
{
    _info = [PersonInfo sharedPersonInfo];
    switch (viewType) {
        case ViewTypeWithCash:
            _firstLabel.text = @"现金收入";
            _secondLabel.text = @"待返利";
            _cashView.hidden = NO;
            _integralBtn.hidden = YES;
            _taoBtn.hidden = YES;
            
            _firstNumLabel.text = [NSString stringWithFormat:@"%ld元",(long)_info.cashAll];
            _secondNumLabel.text = [NSString stringWithFormat:@"%ld元",(long)_info.cashTo];
            break;
        case ViewTypeWithTao:
            _firstLabel.text = @"淘宝集分宝收入";
            _secondLabel.text = @"待返利";
            _cashView.hidden = YES;
            _integralBtn.hidden = YES;
            _taoBtn.hidden = NO;
            
            _firstNumLabel.text = [NSString stringWithFormat:@"%ld个",(long)_info.pointTb];
            _secondNumLabel.text = [NSString stringWithFormat:@"%ld个",(long)_info.pointTbTo];
            break;
        case ViewTypeWithIntegral:
            _firstLabel.text = @"积分收入";
            _infoView.hidden = YES;
            _pointView.hidden = NO;
            _cashView.hidden = YES;
            _integralBtn.hidden = NO;
            _taoBtn.hidden = YES;
            _pointLabel.text = [NSString stringWithFormat:@"%ld分",(long)_info.pointSite];
            break;
    }
    
}


- (IBAction)transForBank:(id)sender
{
    NSInteger cashAll = _info.cashAll;
    if (cashAll < 30) {
        [[BMAlert sharedBMAlert] alert:@"您的现金小于30元，无法提现！" cancle:^(DoAlertView *alertView) {
            
        } other:^(DoAlertView *alertView) {
            
        }];
        return;
    }
    [self createBankView];
    [_bankTransfersView showView];
}

- (IBAction)transForWebSite:(id)sender
{
    ExChangeScrollVC *exChangeScrollVC = [[ExChangeScrollVC alloc] init];
    exChangeScrollVC.leftTitle = @"兑换中心";
    [self.navigationController pushViewController:exChangeScrollVC animated:YES];
}

- (IBAction)transForAlipay:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self createAliView];
    switch (btn.tag) {
        case 1000:
            /*现金收入*/
            if (_info.cashAll < 30) {
                [[BMAlert sharedBMAlert] alert:@"您的现金小于30元，无法提现！" cancle:^(DoAlertView *alertView) {
                    
                } other:^(DoAlertView *alertView) {
                    
                }];
                return;
            }
            [_aliTransfersView showView:1];
            break;
        case 1001:
            /*集分宝收入*/
            if (_info.pointSite < 100) {
                [[BMAlert sharedBMAlert] alert:@"您的集分宝小于100元，无法提现！" cancle:^(DoAlertView *alertView) {
                    
                } other:^(DoAlertView *alertView) {
                    
                }];
                return;
            }
            [_aliTransfersView showView:2];
            break;
    }
}

#pragma mark -- Private

@end
