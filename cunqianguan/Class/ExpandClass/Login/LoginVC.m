//
//  LoginVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/20.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "ForgetVC.h"

#import "BindAccountVC.h"
#import "FinishInfoVC.h"
#import "BindAccountVC.h"

#import "Constants.h"
#import "PersonInfo.h"
#import "LoginConnect.h"
#import "BaseUtil.h"
#import "BMAlert.h"
#import "DoAlertView.h"

#import "UMSocial.h"

@interface LoginVC ()<UITextFieldDelegate>
{
    NSTimer *_hideTimer;
}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.  
    [self initNavBar];
    [self setUpTextField];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Private
-(void)initNavBar
{
    //设置导航栏内容
    NSString *btnTitleStr = @"注册";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [button setTitle:btnTitleStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:btnTitleStr forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateHighlighted];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:17.0];
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (iOS7) {
        //iOS7 custom leftBarButtonItem 偏移
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, btnItem];
    }else{
        self.navigationItem.rightBarButtonItem = btnItem;
    }
    [button addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setUpTextField
{
    _username.delegate = self;
    _pwd.delegate = self;
}

-(void)hideKeyBoard
{
    [_username resignFirstResponder];
    [_pwd resignFirstResponder];
}

- (IBAction)forgetPwdAction:(id)sender
{
    ForgetVC *forgetVC = [[ForgetVC alloc] init];
    forgetVC.leftTitle = @"忘记密码";
    [self.navigationController pushViewController:forgetVC animated:YES];
}


- (void)leftBtnClicked:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)rightBtnClick:(id)sender
{
    RegisterVC *registVC = [[RegisterVC alloc] init];
    registVC.leftTitle = @"注册";
    [self.navigationController pushViewController:registVC animated:YES];
}
- (IBAction)loginAction:(id)sender
{
    [self loginForService];
}

-(void)loginForService
{
    NSString *username = _username.text;
    NSString *pwd = _pwd.text;
    if (username.length == 0 || pwd.length == 0) {
        [self showStringHUD:@"用户名或密码不能为空！" second:HUD_SHOW_SECOND];
        return;
    }
    pwd = [BaseUtil encrypt:pwd];
    [self showHUD:LOGIN_LOAD];
    [[LoginConnect sharedLoginConnect] loginByAccount:username withPwd:pwd success:^(id json) {
        __weak NSString *weakName = username;
        __weak NSString *weakPwd = pwd;
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"data"] objectForKey:@"rewardNotice"]  forKey:@"rewardNotice"];
            /*获取个人资料*/
            PersonInfo *person = [PersonInfo sharedPersonInfo];
            person.password = pwd;
            [person loginSuccessWith:[dic objectForKey:@"data"]];
            [person getUserInfo:weakName withPwd:weakPwd success:^(id json) {
                [self hideAllHUD];
                if([BaseConnect isSucceeded:json]){
                    [self showStringHUD:@"登陆成功" second:HUD_SHOW_SECOND];
                    _hideTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismisSelf) userInfo:nil repeats:NO];
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

-(void)loginForHandle:(LoginSuccessHandler *)loginSuccessHandler
{
    
}

-(void)dismisSelf
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)registForThirdPart:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1000) {
        [self registForQQ];
    }else{
        [self registForWeibo];
    }
}

-(void)registForWeibo
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            if (![snsAccount.usid isEqual:[NSNull null]]) {
                [self thirdLoginFinish:snsAccount andType:@"wb"];
//                [[LoginConnect sharedLoginConnect] getUserByOauth:snsAccount.usid success:^(id json) {
//                    NSDictionary *dic = (NSDictionary *)json;
//                    /*绑定过*/
//                    if (![BaseConnect isSucceeded:dic]) {
//                        FinishInfoVC *finishInfoVC = [[FinishInfoVC alloc] init];
//                        finishInfoVC.leftTitle = @"注册";
//                        finishInfoVC.uuid = snsAccount.usid;
//                        finishInfoVC.username = snsAccount.userName;
//                        finishInfoVC.type = @"wb";
//                        [self.navigationController pushViewController:finishInfoVC animated:YES];
//                    }else{
//                        [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"data"] objectForKey:@"rewardNotice"]  forKey:@"rewardNotice"];
//                        NSString *userId = snsAccount.usid;
//                        /*获取个人资料*/
//                        PersonInfo *person = [PersonInfo sharedPersonInfo];
//                        person.isThirdLogin = YES;
//                        if (userId.length > 20) {
//                            userId = [userId substringToIndex:20];
//                        }
//                        person.password = userId;
//                        [person loginSuccessWith:[dic objectForKey:@"data"]];
//                        [self dismissViewControllerAnimated:NO completion:^{
//                            [[NSNotificationCenter defaultCenter] postNotificationName:kRegistFinish object:nil];
//                        }];
//                    }
//                } failure:^(NSError *err) {
//                    
//                }];
            }else{
                [self hideAllHUD];
                [self showStringHUD:@"授权失败" second:1.5];
            }
          }else{
            
        }
    });
}

-(void)registForQQ
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            if (![snsAccount.usid isEqual:[NSNull null]]) {
                [self thirdLoginFinish:snsAccount andType:@"qq"];
            }else{
                [self hideAllHUD];
                [self showStringHUD:@"授权失败" second:1.5];
            }
//            [[LoginConnect sharedLoginConnect] getUserByOauth:snsAccount.usid success:^(id json) {
//                NSDictionary *dic = (NSDictionary *)json;
//                /*绑定过*/
//                if (![BaseConnect isSucceeded:dic]) {
//                    FinishInfoVC *finishInfoVC = [[FinishInfoVC alloc] init];
//                    finishInfoVC.leftTitle = @"注册";
//                    finishInfoVC.uuid = snsAccount.usid;
//                    finishInfoVC.username = snsAccount.userName;
//                    finishInfoVC.type = @"qq";
//                    [self.navigationController pushViewController:finishInfoVC animated:YES];
//                }else{
//                    [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"data"] objectForKey:@"rewardNotice"]  forKey:@"rewardNotice"];
//                    NSString *userId = snsAccount.usid;
//                    /*获取个人资料*/
//                    PersonInfo *person = [PersonInfo sharedPersonInfo];
//                    person.isThirdLogin = YES;
//                    if (userId.length > 20) {
//                        userId = [BaseUtil encrypt:[userId substringToIndex:20]];
//                    }
//                    person.password = userId;
//                    [person loginSuccessWith:[dic objectForKey:@"data"]];
//                    [self dismissViewControllerAnimated:NO completion:^{
//                        [[NSNotificationCenter defaultCenter] postNotificationName:kRegistFinish object:nil];
//                    }];
//                }
//            } failure:^(NSError *err) {
//                
//            }];
        }else{
            
        }
    });
}

#pragma mark -- 第三方登陆获取授权成功
-(void)thirdLoginFinish:(UMSocialAccountEntity *)snsAccount andType:(NSString *)type
{
    [[LoginConnect sharedLoginConnect] getUserByOauth:snsAccount.usid success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        /*绑定过*/
        if (![BaseConnect isSucceeded:dic]) {
            FinishInfoVC *finishInfoVC = [[FinishInfoVC alloc] init];
            finishInfoVC.leftTitle = @"注册";
            finishInfoVC.uuid = snsAccount.usid;
            finishInfoVC.username = snsAccount.userName;
            finishInfoVC.type = type;
            [self.navigationController pushViewController:finishInfoVC animated:YES];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:[[dic objectForKey:@"data"] objectForKey:@"rewardNotice"]  forKey:@"rewardNotice"];
            NSString *userId = snsAccount.usid;
            /*获取个人资料*/
            PersonInfo *person = [PersonInfo sharedPersonInfo];
            person.isThirdLogin = YES;
            if (userId.length > 20) {
                userId = [userId substringToIndex:20];
            }
            person.password = [BaseUtil encrypt:userId];
            [person loginSuccessWith:[dic objectForKey:@"data"]];
            [self dismissViewControllerAnimated:NO completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kRegistFinish object:nil];
            }];
        }
    } failure:^(NSError *err) {
        
    }];
}


- (IBAction)clearAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    _username.text = @"";
    btn.hidden = YES;
}

- (IBAction)showPwdAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.selected) {
        btn.selected = NO;
        _pwd.secureTextEntry = YES;
        return;
    }
    btn.selected = YES;
    _pwd.secureTextEntry = NO;
}

#pragma mark -- UITextfiledDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _username) {
        _clearBtn.hidden = NO;
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _userimage.highlighted = (textField == _username);
    _pwdimage.highlighted = (textField == _pwd);
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField.returnKeyType == UIReturnKeyNext)
    {
        [_pwd becomeFirstResponder];
        return YES;
    }
    [textField resignFirstResponder];
    [self loginForService];
    return YES;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
