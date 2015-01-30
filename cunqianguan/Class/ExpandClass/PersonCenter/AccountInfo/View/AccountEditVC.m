//
//  AccountEditVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "AccountEditVC.h"
@interface AccountEditVC ()

@end

@implementation AccountEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(void)refreshViewWith:(ViewType)viewType
{
    switch (viewType) {
        case ViewTypeWithAipay:
            _AlipayView.hidden = NO;
            _bankCardView.hidden = YES;
            break;
        case ViewTypeWithBank:
            _AlipayView.hidden = YES;
            _bankCardView.hidden = NO;
            break;
        default:
            break;
    }
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (_viewType) {
        case ViewTypeWithBank:
            if (textField == _bankNumText){
                [self changeViewPath];
            }
            break;
        default:
            break;
    }
    
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    switch (_viewType) {
        case ViewTypeWithAipay:
            if (textField == _aliPayText) {
                [_aliPayPwdText becomeFirstResponder];
            }else if (textField == _aliPayPwdText){
                [_aliPayPwdText resignFirstResponder];
            }
            break;
        case ViewTypeWithBank:
            if (textField == _bankNameText) {
                [_bankCityText becomeFirstResponder];
            }else if (textField == _bankCityText){
                [_bankText becomeFirstResponder];
            }else if (textField == _bankText){
                [_bankNumText becomeFirstResponder];
                [self changeViewPath];
            }else if (textField == _bankNumText){
                [_bankPwdText becomeFirstResponder];
            }else if (textField == _bankPwdText){
                [_bankPwdText resignFirstResponder];
                [self returnNormalPath];
            }
            break;
        default:
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

@end
