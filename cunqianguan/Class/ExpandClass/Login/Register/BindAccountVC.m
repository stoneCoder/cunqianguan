//
//  RegisterVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/21.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BindAccountVC.h"
#import "LocalWebVC.h"

#import "Constants.h"
#import "PersonInfo.h"
#import "LoginConnect.h"
#import "BaseUtil.h"
#import "BMAlert.h"

@interface BindAccountVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwdtext;
@property (weak, nonatomic) IBOutlet UIImageView *userimage;
@property (weak, nonatomic) IBOutlet UIImageView *pwdimage;

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
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        [self showStringHUD:[dic objectForKey:@"info"] second:1.5];
        if ([BaseConnect isSucceeded:dic]) {
            /*注册完成自动登陆*/
            [[LoginConnect sharedLoginConnect] loginByAccount:username withPwd:pwd success:^(id json) {
                NSDictionary *dic = (NSDictionary *)json;
                if ([BaseConnect isSucceeded:dic]) {
                    [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"data"] objectForKey:@"rewardNotice"] forKey:@"rewardNotice"];
                    /*获取个人资料*/
                    PersonInfo *person = [PersonInfo sharedPersonInfo];
                    person.password = pwd;
                    [person loginSuccessWith:[dic objectForKey:@"data"]];
                    [person getUserInfo:username withPwd:pwd success:^(id json) {
                        [self hideAllHUD];
                        if([BaseConnect isSucceeded:json]){
                            [self dismissViewControllerAnimated:NO completion:^{
                                [[NSNotificationCenter defaultCenter] postNotificationName:kRegistFinish object:@"RegistFinish"];
                            }];
                        }
                    } failure:^(id json) {
                        [self hideAllHUD];
                    }];
                }else{
                    [self hideAllHUD];
                    [self showStringHUD:[dic objectForKey:@"info"] second:HUD_SHOW_SECOND];
                    return;
                }
            } failure:^(NSError *err) {
                [self hideAllHUD];
                [[BMAlert sharedBMAlert] alert:@"网络连接异常" cancle:^(DoAlertView *alertView) {
                } other:nil];
            }];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}
- (IBAction)protocolAction:(id)sender {
    LocalWebVC *loaclWebVC = [[LocalWebVC alloc] init];
    loaclWebVC.leftTitle = @"用户协议";
    loaclWebVC.loadType = 1;
    [self.navigationController pushViewController:loaclWebVC animated:YES];
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
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    _userimage.highlighted = (textField == _username);
    _pwdimage.highlighted = (textField == _pwdtext);
    return YES;
}

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
