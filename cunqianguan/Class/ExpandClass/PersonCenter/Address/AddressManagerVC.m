//
//  AddressManagerVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "AddressManagerVC.h"

@interface AddressManagerVC ()<UITextFieldDelegate>
{
    BOOL _isHaveAddress;
}

@end

@implementation AddressManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _emptyView.backgroundColor = UIColorFromRGB(0xececec);
    _editView.backgroundColor = UIColorFromRGB(0xececec);
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

#pragma MARK -- UITextFieldDelegate
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
