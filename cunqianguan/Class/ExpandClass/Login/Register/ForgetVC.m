//
//  ForgetVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/21.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ForgetVC.h"
#import "LoginConnect.h"
#import "BaseConnect.h"
#import "BMAlert.h"

@interface ForgetVC ()
@property (weak, nonatomic) IBOutlet UITextField *emailtext;

@end

@implementation ForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
- (IBAction)findPwd:(id)sender
{
    NSString *email = _emailtext.text;
    if (email.length == 0) {
        [self showStringHUD:@"请输入邮箱地址" second:2];
        return;
    }
    
    [[LoginConnect sharedLoginConnect] findPwdByAccount:email success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            [[BMAlert sharedBMAlert] alert:@"系统已将修改地址发送到您的邮箱中，请登陆邮箱中的地址设置新密码！" cancle:^(DoAlertView *alertView) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } other:^(DoAlertView *alertView) {
                
            }];
        }else{
            [self showStringHUD:[dic objectForKey:@"info"] second:2];
        }
    } failure:^(NSError *err) {
        
    }];
}
#pragma mark -- Private
-(void)hideKeyBoard
{
    [_emailtext resignFirstResponder];
}

@end
