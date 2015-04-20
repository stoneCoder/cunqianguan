//
//  AccountEditVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "AccountEditVC.h"
#import "TGCCustomPickerView.h"

#import "PersonConnect.h"
#import "BaseConnect.h"
#import "PersonInfo.h"
#import "BaseUtil.h"
#import "CityModel.h"
#import "CityListModel.h"


@interface AccountEditVC ()<TGCCustomPickerViewDelegate>
{
    PersonInfo *_info;
    TGCCustomPickerView *_pickerView;
    NSInteger _pickerViewTag; //0 银行 1 城市
    BOOL _ifShowPicerView;
    NSArray *_topArray;
    NSArray *_subArray;
    CityModel *_selectTopModel;
    CityModel *_selectSubModel;
}

@end

@implementation AccountEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    [self refreshViewWith:_viewType];
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

-(void)refreshViewWith:(EditViewType)viewType
{
    switch (viewType) {
        case ViewTypeWithAipay:
            _AlipayView.hidden = NO;
            _bankCardView.hidden = YES;
            
            if (_model.alipay.length > 0) {
                [_bindAliBtn setTitle:@"修改支付宝" forState:UIControlStateNormal];
            }else{
                [_bindAliBtn setTitle:@"设置支付宝" forState:UIControlStateNormal];
            }
            [_bindAliBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x2db8ad)] forState:UIControlStateNormal];
            [_bindAliBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x179a90)] forState:UIControlStateHighlighted];
            _bindAliBtn.layer.cornerRadius = 5.0f;
            _bindAliBtn.layer.masksToBounds = YES;
            break;
        case ViewTypeWithBank:
            _AlipayView.hidden = YES;
            _bankCardView.hidden = NO;
            _bankCardView.backgroundColor = self.view.backgroundColor;
            
            if (_model.bank.length > 0) {
                [_bindBankBtn setTitle:@"修改银行卡" forState:UIControlStateNormal];
            }else{
                [_bindBankBtn setTitle:@"设置银行卡" forState:UIControlStateNormal];
            }
            [_bindBankBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xed4142)] forState:UIControlStateNormal];
            [_bindBankBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xd22223)] forState:UIControlStateHighlighted];
            _bindBankBtn.layer.cornerRadius = 5.0f;
            _bindBankBtn.layer.masksToBounds = YES;
            break;
        default:
            break;
    }
}
- (IBAction)bindBankCard:(id)sender
{
    NSString *name = _bankNameText.text;
    NSString *provine = _bankCityText.text;
    NSString *country = _bankText.text;
    NSString *bankNum = _bankNumText.text;
    NSString *pwd = _bankPwdText.text;
    if (name.length == 0 || provine.length == 0 || country.length == 0 || bankNum.length == 0 || pwd.length == 0) {
        [self showStringHUD:@"请填写完整" second:2];
        return;
    }
    pwd = [BaseUtil encrypt:pwd];
    NSLog(@"%@<---------->%@",_selectSubModel,_selectTopModel);
    [self showHUD:ACTION_LOAD];
    [[PersonConnect sharedPersonConnect] updateBankAccount:_info.email pwd:pwd bankaccount:bankNum consignee:name area:_selectSubModel.cityId bank:1 success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showStringHUD:[dic objectForKey:@"info"] second:2];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
   
}

- (IBAction)bindAlipay:(id)sender
{
    NSString *alipayName = _aliPayNameText.text;
    NSString *alipayNum = _aliPayText.text;
    NSString *alipayPwd = _aliPayPwdText.text;
    if (alipayName.length == 0 || alipayNum.length == 0 || alipayPwd.length == 0) {
        [self showStringHUD:@"请填写完整" second:2];
        return;
    }
    
    [self showHUD:ACTION_LOAD];
    alipayPwd = [BaseUtil encrypt:alipayPwd];
    [[PersonConnect sharedPersonConnect] updateAlipay:_info.email pwd:alipayPwd aliaccount:alipayNum aliName:alipayName success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showStringHUD:[dic objectForKey:@"info"] second:2];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

#pragma mark -- Private
-(void)loadParentCityInfo
{
    [[PersonConnect sharedPersonConnect] getTopArea:[NSDictionary dictionary] success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            CityListModel *listModel = [[CityListModel alloc] initWithDictionary:dic error:nil];
            _topArray = listModel.data;
            _pickerViewTag = 0;
            
            [self showPicker:_topArray];
        }
    } failure:^(NSError *err) {
        
    }];
}

-(void)loadCityInfo:(NSInteger)areadId
{
    [[PersonConnect sharedPersonConnect] getSubArea:areadId success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            CityListModel *listModel = [[CityListModel alloc] initWithDictionary:dic error:nil];
            _subArray = listModel.data;
            _pickerViewTag = 1;
            [self showPicker:_subArray];
        }
    } failure:^(NSError *err) {
        
    }];
}

-(void)showPicker:(NSArray *)data
{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (_pickerView) {
        [_pickerView dismiss];
        _pickerView = nil;
    }
   
    NSMutableArray *dataArray = [NSMutableArray array];
    for (CityModel *model in data) {
        [dataArray addObject:model.name];
    }
    _pickerView = [[TGCCustomPickerView alloc] initWithFrame:CGRectMake(0, height, self.view.bounds.size.width, 280) andPickerViewType:kTGCPickerViewTypeCustom andComponents:1];
    _pickerView.componentDics = [NSMutableDictionary dictionaryWithObject:dataArray forKey:@"0"];
    _pickerView.delegate = self;
    [self.view addSubview:_pickerView];
    [_pickerView show];
}


-(void)disableEdit
{
    [_bankNameText resignFirstResponder];
    [_bankCityText resignFirstResponder];
    [_bankText resignFirstResponder];
    [_bankNumText resignFirstResponder];
    [_bankPwdText resignFirstResponder];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (_viewType) {
        case ViewTypeWithBank:
            if (textField == _bankNumText){
                [self changeViewPath];
            }
            if(textField == _bankCityText){
                [self disableEdit];
                [self returnNormalPath];
                [self loadParentCityInfo];
                _bankText.text = @"";
                return NO;
            }
            if(textField == _bankText){
                if (!_selectTopModel) {
                    [self showStringHUD:@"请选择上级菜单" second:2];
                    return NO;
                }
                [self disableEdit];
                [self returnNormalPath];
                [self loadCityInfo:_selectTopModel.cityId];
                return NO;
            }
            [_pickerView dismiss];
            break;
    }
    
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    switch (_viewType) {
        case ViewTypeWithAipay:
            if (textField == _aliPayNameText) {
                [_aliPayText becomeFirstResponder];
            }else if (textField == _aliPayText) {
                [_aliPayPwdText becomeFirstResponder];
            }else if (textField == _aliPayPwdText){
                [_aliPayPwdText resignFirstResponder];
            }
            break;
        case ViewTypeWithBank:
            if (textField == _bankNameText) {
                [_bankCityText becomeFirstResponder];
                [self disableEdit];
                [self loadParentCityInfo];
                [self returnNormalPath];
                _bankText.text = @"";
            }else if (textField == _bankCityText){
                if (!_selectTopModel) {
                    [self showStringHUD:@"请选择上级菜单" second:2];
                    return NO;
                }
                [_bankText becomeFirstResponder];
                [self disableEdit];
                [self returnNormalPath];
                [self loadCityInfo:_selectTopModel.cityId];
            }else if (textField == _bankText){
                [self changeViewPath];
            }else if (textField == _bankNumText){
                [_bankPwdText becomeFirstResponder];
                [_pickerView dismiss];
            }else if (textField == _bankPwdText){
                [_bankPwdText resignFirstResponder];
                [self returnNormalPath];
                [_pickerView dismiss];
            }
            break;
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

#pragma mark - TGCCustomPickerViewDelegate
- (void)didPickerView:(UIPickerView *)pickerView selectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < _pickerView.components; i++) {
        NSInteger rowCount = [pickerView selectedRowInComponent:i];
        [array addObject:[NSString stringWithFormat:@"%ld", (long)rowCount]];
    }
    [_pickerView forDataShowingStringWithRowsCount:array];
    if(_pickerViewTag == 0){
        _selectTopModel = _topArray[row];
        _bankCityText.text = _pickerView.showingString;
    }else if (_pickerViewTag == 1) {
        _selectSubModel = _subArray[row];
        _bankText.text = _pickerView.showingString;
    }
}

- (void)didShowPickerView:(UIView *)pickerView {
    _ifShowPicerView = YES;
    if(_pickerViewTag == 0){
        _selectTopModel = _topArray[0];
        _bankCityText.text = _pickerView.showingString;
    }else if (_pickerViewTag == 1) {
        _selectSubModel = _subArray[0];
        _bankText.text = _pickerView.showingString;
    }
}

- (void)didDismissPickerView {
    _ifShowPicerView = NO;
}

- (void)didFinishPicker {
    _ifShowPicerView = NO;
    if(_pickerViewTag == 0){
        _bankCityText.text = _pickerView.showingString;
    }else if (_pickerViewTag == 1) {
        _bankText.text = _pickerView.showingString;
    }
}

@end
