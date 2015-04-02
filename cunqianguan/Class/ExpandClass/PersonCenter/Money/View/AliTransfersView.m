//
//  AliTransfersView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "AliTransfersView.h"
#import "PersonInfo.h"
#import "PersonConnect.h"
#import "BaseConnect.h"
#import "BaseUtil.h"
@implementation AliTransfersView
{
    PersonInfo *_info;
    NSInteger _type;
    BankModel *_model;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(AliTransfersView *)transfersView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    AliTransfersView *aliTransfersView = nil;
    if ([nibs count]) {
        aliTransfersView = [nibs objectAtIndex:0];
        [aliTransfersView setUpView];
    }
    return aliTransfersView;
}

-(void)setUpView
{
    _info = [PersonInfo sharedPersonInfo];
    self.hidden = YES;
    self.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.3];
    _contentView.backgroundColor = UIColorFromRGB(0x2db8ad);
    _numText.delegate = self;
    _pwdText.delegate = self;
    
    _tipLabel.numberOfLines = 0;
    _tipLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    _cancleBtn.layer.borderWidth = 1.0f;
    _cancleBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [_cancleBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x07B8AD)] forState:UIControlStateNormal];
    [_cancleBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xBCBCBC)] forState:UIControlStateHighlighted];
    
    _subBtn.layer.borderWidth = 1.0f;
    _subBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [_subBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x07B8AD)] forState:UIControlStateNormal];
    [_subBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xBCBCBC)] forState:UIControlStateHighlighted];
    
}
- (IBAction)cancleAction:(id)sender
{
    [self hideView];
    [_numText resignFirstResponder];
    [_pwdText resignFirstResponder];
}

- (IBAction)submitAction:(id)sender
{
    NSString *money = _numText.text;
    NSString *pwd = _pwdText.text;
    if (money.length == 0 || pwd.length == 0) {
        [self showStringHUD:@"请填写完整" second:2];
        return;
    }
    switch (_type) {
        case 1:
            if([money integerValue] > _info.cashAll){
                [self showStringHUD:@"提现数量不能大于可提现数量！" second:2];
                return;
            }
            
            if([money integerValue] < 30 || [money integerValue]%5 != 0){
                [self showStringHUD:@"提现金额需大于等于30且为5的整数倍！" second:2];
                return;
            }
            break;
        case 2:
            if([money integerValue] > _info.pointSite){
                [self showStringHUD:@"提现数量不能大于可提现数量！" second:2];
                return;
            }
            
            if([money integerValue]%100 != 0){
                [self showStringHUD:@"提现必须是100的整数倍！" second:2];
                return;
            }
            break;
    }
    
    [self showHUD:ACTION_LOAD];
    pwd = [BaseUtil encrypt:pwd];
    [[PersonConnect sharedPersonConnect] getUserExtract:_info.email andPwd:pwd withMoney:[money integerValue] type:_type success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        [self showStringHUD:[dic objectForKey:@"info"] second:1.5];
        if ([BaseConnect isSucceeded:dic]) {
            _numText.text = @"";
            _pwdText.text = @"";
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
    
}

-(void)showView:(NSInteger)type WithModel:(BankModel *)bankModel
{
    _type = type;
    _model = bankModel;
    switch (type) {
        case 1:
            _canMoneyTitleLabel.text = @"可提现金额：";
            _moneyTitleLabel.text = @"提现金额：";
            _tipLabel.text = @"(大于等于30且为5的整数倍)";
            break;
    }
    [self loadData];
    [UIView animateWithDuration:0.25 animations:^{
        self.hidden = NO;
    }];
}

-(void)hideView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.hidden = YES;
    } completion:^(BOOL finished) {
        //[self removeFromSuperview];
    }];
}

-(void)loadData
{
    _aliNumLabel.text = _model.alipay;
    if (_type == 1) {
        _moneyLabel.text = [NSString stringWithFormat:@"%ld元",(long)_info.cashAll];
    }else if (_type == 2){
        _moneyLabel.text = [NSString stringWithFormat:@"%ld",(long)_info.pointSite];
    }
    _numText.text = @"";
    _pwdText.text = @"";
//    [self showHUD:DATA_LOAD];
//    [[PersonConnect sharedPersonConnect] getUserBankInfo:_info.email andPwd:_info.password success:^(id json) {
//        [self hideAllHUD];
//        NSDictionary *dic = (NSDictionary *)json;
//        if ([BaseConnect isSucceeded:dic]) {
//            _model = [[BankModel alloc] initWithDictionary:[dic objectForKey:@"data"] error:nil];
//            
//        }
//    } failure:^(NSError *err) {
//        [self hideAllHUD];
//    }];
}

#pragma mark -- UITextfiledDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _numText)
    {
        [_pwdText becomeFirstResponder];
        return YES;
    }
    [_pwdText resignFirstResponder];
    return YES;
}
@end
