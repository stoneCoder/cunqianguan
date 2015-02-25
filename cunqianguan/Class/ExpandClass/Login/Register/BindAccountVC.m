//
//  RegisterVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/21.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BindAccountVC.h"

#import "PersonInfo.h"
#import "LoginConnect.h"
#import "BaseUtil.h"
#import "BMAlert.h"

@interface BindAccountVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwdtext;

@end

@implementation BindAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _username.delegate = self;
    _pwdtext.delegate = self;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)bindAction:(id)sender
{
    NSString *username = _username.text;
    NSString *pwd = _pwdtext.text;
    if (username.length == 0 || pwd.length == 0) {
        [self showStringHUD:@"用户名或密码不能为空！" second:HUD_SHOW_SECOND];
        return;
    }
    pwd = [BaseUtil encrypt:pwd];
    [self showHUD:LOGIN_LOAD];
    
    [[LoginConnect sharedLoginConnect] bindOauth:username withPwd:pwd name:_name uuid:_uuid type:_type success:^(id json) {
        
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
#pragma mark -- Private
-(void)hideKeyBoard
{
    [_username resignFirstResponder];
    [_pwdtext resignFirstResponder];
}

#pragma mark -- UITextfiledDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _username)
    {
        [_pwdtext becomeFirstResponder];
        return YES;
    }
    [textField resignFirstResponder];
    return YES;
}

@end
