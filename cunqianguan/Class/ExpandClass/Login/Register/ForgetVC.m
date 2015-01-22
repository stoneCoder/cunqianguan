//
//  ForgetVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/21.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ForgetVC.h"

@interface ForgetVC ()
@property (weak, nonatomic) IBOutlet UITextField *emailtext;

@end

@implementation ForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleText:@"忘记密码"];
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
    [_emailtext resignFirstResponder];
}

@end
