//
//  BankTransfersView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BankTransfersView.h"

#import "BaseUtil.h"
#import "PersonInfo.h"
#import "PersonConnect.h"
#import "BaseConnect.h"
#import "BankModel.h"
@implementation BankTransfersView
{
    PersonInfo *_info;
    BankModel *_model;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(BankTransfersView *)transfersView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    BankTransfersView *bankTransfersView = nil;
    if ([nibs count]) {
        bankTransfersView = [nibs objectAtIndex:0];
        [bankTransfersView setUpView];
    }
    return bankTransfersView;
}

-(void)setUpView
{
    _info = [PersonInfo sharedPersonInfo];
    self.hidden = YES;
    self.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.3];
    _numText.delegate = self;
    _pwdText.delegate = self;
}
- (IBAction)cancleAction:(id)sender
{
    [self hideView];
    [_numText resignFirstResponder];
    [_pwdText resignFirstResponder];
    [self returnNormalPath];
}

- (IBAction)submitAction:(id)sender
{
    NSString *money = _numText.text;
    NSString *pwd = _pwdText.text;
    if (money.length == 0 || pwd.length == 0) {
        [self showStringHUD:@"请填写完整" second:2];
        return;
    }
    if([money integerValue] > _info.cashAll){
        [self showStringHUD:@"提现数量不能大于可提现数量！" second:2];
        return;
    }
    
    if([money integerValue] < 30 || [money integerValue]%5 != 0){
        [self showStringHUD:@"提现金额需大于等于30且为5的整数倍！" second:2];
        return;
    }
    pwd = [BaseUtil encrypt:pwd];
    [self showHUD:ACTION_LOAD];
    [[PersonConnect sharedPersonConnect] getUserExtract:_info.email andPwd:pwd withMoney:[money integerValue] type:0 success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        [self showStringHUD:[dic objectForKey:@"info"] second:2];
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

-(void)loadData
{
    [self showHUD:DATA_LOAD];
    [[PersonConnect sharedPersonConnect] getUserBankInfo:_info.email andPwd:_info.password success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _model = [[BankModel alloc] initWithDictionary:[dic objectForKey:@"data"] error:nil];
            _nameLabel.text = _model.name;
            _cityLabel.text = _model.city;
            _bankNameLabel.text = _model.bankname;
            _moneyLabel.text = [NSString stringWithFormat:@"%ld元",(long)_info.cashAll];
            _cardNumLabel.text = [BaseUtil transformBankCard:_model.bank];
            _numText.text = @"";
            _pwdText.text = @"";
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

-(void)showView
{
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

-(void)changeViewPath
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    self.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 64);
    [UIView commitAnimations];
}

-(void)returnNormalPath
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    self.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2);
    [UIView commitAnimations];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _numText){
        [self changeViewPath];
    }
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _numText)
    {
        [_pwdText becomeFirstResponder];
        [self changeViewPath];
        return YES;
    }
    [_pwdText resignFirstResponder];
    [self returnNormalPath];
    return YES;
}
@end
