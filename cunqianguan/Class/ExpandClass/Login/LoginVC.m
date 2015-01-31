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

@interface LoginVC ()<UITextFieldDelegate>

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

- (IBAction)registForThirdPart:(id)sender
{
   
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

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField.returnKeyType == UIReturnKeyNext)
    {
        NSLog(@"I click username");
        [_pwd becomeFirstResponder];
        return YES;
    }
    [textField resignFirstResponder];
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
