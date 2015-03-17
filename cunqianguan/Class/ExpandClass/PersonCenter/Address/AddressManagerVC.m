//
//  AddressManagerVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "AddressManagerVC.h"
#import "PersonInfo.h"
#import "PersonConnect.h"
#import "ExChangeConnect.h"
#import "BaseConnect.h"
#import "Constants.h"
@interface AddressManagerVC ()<UITextFieldDelegate>
{
    BOOL _isHaveAddress;
    PersonInfo *_info;
}

@end

@implementation AddressManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _emptyView.backgroundColor = UIColorFromRGB(0xececec);
    //_editView.backgroundColor = UIColorFromRGB(0xececec);
    _info = [PersonInfo sharedPersonInfo];
    /*显示编辑*/
    if (_info.consignee && ![_info.consignee isEqual:[NSNull null]]) {
        _isHaveAddress = YES;
        _emptyView.hidden = YES;
        _editView.hidden = NO;
        [self loadData];
        if (_isExChange) {
            _subBtn.hidden = NO;
            [self disabledit:YES];
        }else{
            _subBtn.hidden = YES;
            [self disabledit:NO];
            [self setUpNavBtn];
        }
    }else{
        _isHaveAddress = NO;
        _emptyView.hidden = NO;
        _editView.hidden = YES;
    }
}

-(void)setUpNavBtn
{
    if (_isHaveAddress) {
        [self setRigthBarWithDic:@{@"images":@[@"edit"],@"imageshover":@[@"edit_down"]}];
    }
}

-(void)rightBtnClick:(id)sender
{
    [self disabledit:YES];
    _subBtn.hidden = NO;
    [_receiveText becomeFirstResponder];
}

#pragma mark -- Private
-(void)disabledit:(BOOL)enabled
{
    _receiveText.enabled = enabled;
    _addressText.enabled = enabled;
    _zipCodeText.enabled = enabled;
    _qqCodeText.enabled = enabled;
    _phoneText.enabled = enabled;
}

-(void)loadData
{
    _receiveText.text = _info.consignee;
    _addressText.text = _info.location;
    _zipCodeText.text = _info.zipCode;
    _qqCodeText.text = _info.qq;
    _phoneText.text = _info.phone;
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
- (IBAction)addAddress:(id)sender
{
    _emptyView.hidden = YES;
    [UIView animateWithDuration:1.0f animations:^{
        _editView.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}
- (IBAction)subAction:(id)sender
{
    NSString *consignee = _receiveText.text;
    NSString *location = _addressText.text;
    NSString *zipCode = _zipCodeText.text;
    NSString *qqCode = _qqCodeText.text;
    NSString *phone = _phoneText.text;
    
    if (consignee.length == 0 || location.length == 0 || zipCode.length == 0 || qqCode.length == 0 || phone.length == 0) {
        [self showStringHUD:@"请填写完整" second:1.5];
        return;
    }
    
    [self showHUD:ACTION_LOAD];
    if (!_isExChange) {
        [[PersonConnect sharedPersonConnect] updateAddress:_info.email pwd:_info.password consignee:consignee location:location zipCode:zipCode qq:qqCode phone:phone success:^(id json) {
            [self hideAllHUD];
            NSDictionary *dic = (NSDictionary *)json;
            [self showStringHUD:[dic objectForKey:@"info"] second:1.5];
            if ([BaseConnect isSucceeded:dic]) {
                _info.consignee = consignee;
                _info.location = location;
                _info.zipCode = zipCode;
                _info.qq = qqCode;
                _info.phone = phone;
                [_info saveUserData];
                
                [self disabledit:NO];
                _subBtn.hidden = YES;
            }
        } failure:^(NSError *err) {
            [self hideAllHUD];
        }];
    }else{
        [[ExChangeConnect sharedExChangeConnect] exchangeGood:_info.email pwd:_info.password productId:_productId phone:phone qq:qqCode success:^(id json) {
            [self hideAllHUD];
            NSDictionary *dic = (NSDictionary *)json;
            if ([BaseConnect isSucceeded:dic]) {
                [self disabledit:NO];
                _subBtn.hidden = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:kExChangeSuccess object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *err) {
             [self hideAllHUD];
        }];
    }
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _qqCodeText){
        [self changeViewPath];
    }
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _receiveText) {
        [_addressText becomeFirstResponder];
    }else if (textField == _addressText){
        [_zipCodeText becomeFirstResponder];
    }else if (textField == _zipCodeText){
        [_qqCodeText becomeFirstResponder];
        [self changeViewPath];
    }else if (textField == _qqCodeText){
        [_phoneText becomeFirstResponder];
    }else if (textField == _phoneText){
        [_phoneText resignFirstResponder];
        [self returnNormalPath];
    }
    return YES;
}

-(void)changeViewPath
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    self.view.center = CGPointMake(VIEW_WIDTH/2.0, VIEW_HEIGHT/2);
    [UIView commitAnimations];
}

-(void)returnNormalPath
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    self.view.center = CGPointMake(VIEW_WIDTH/2.0, VIEW_HEIGHT/2.0 + 64);
    [UIView commitAnimations];
}
@end
