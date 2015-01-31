//
//  RegisterVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/21.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "RegisterVC.h"

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
