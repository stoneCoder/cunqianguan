//
//  RegisterVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/21.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "RegisterVC.h"

#import "BMAlert.h"
#import "BaseUtil.h"
#import "LoginConnect.h"

@interface RegisterVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *emailtext;
@property (weak, nonatomic) IBOutlet UITextField *pwdtext;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _username.delegate = self;
    _emailtext.delegate = self;
    _pwdtext.delegate = self;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)]];
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
- (IBAction)registAction:(id)sender
{
    NSString *username = _username.text;
    NSString *email = _emailtext.text;
    NSString *pwd = _pwdtext.text;
    if (username.length == 0 || email.length == 0 || pwd.length == 0) {
        [self showStringHUD:@"请填写完整" second:2];
        return;
    }
    pwd = [BaseUtil encrypt:pwd];
    [self showHUD:ACTION_LOAD];
    [[LoginConnect sharedLoginConnect] registByAccount:email userName:username withPwd:pwd success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        [self showStringHUD:[dic objectForKey:@"info"] second:2];
    } failure:^(NSError *err) {
        [self hideAllHUD];
        [[BMAlert sharedBMAlert] alert:@"网络连接异常" cancle:^(DoAlertView *alertView) {
        } other:nil];
    }];
}
#pragma mark -- Private
-(void)hideKeyBoard
{
    [_username resignFirstResponder];
    [_emailtext resignFirstResponder];
    [_pwdtext resignFirstResponder];
}

#pragma mark -- UITextfiledDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _username)
    {
        [_emailtext becomeFirstResponder];
        return YES;
    }else if (textField == _emailtext)
    {
        [_pwdtext becomeFirstResponder];
        return YES;
    }
    [textField resignFirstResponder];
    return YES;
}

@end
