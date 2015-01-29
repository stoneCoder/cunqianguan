//
//  RebateHomeVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/22.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "RebateHomeVC.h"

@interface RebateHomeVC ()

@end

@implementation RebateHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self hideReturnBtn];
    [self setUpNavBtn];
    
}

-(void)setUpNavBtn
{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"home_hover"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(pushToHome) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    NSDictionary *imageDic = @{@"images":@[@"share",@"jiaoya",@"taobao_btn"],@"imageshover":@[@"share_hover",@"jiaoya_hover",@"taobao_btn_hover"]};
    [self setRigthBarWithDic:imageDic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushToHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)rightBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%ld---------->qweqweqwe",(long)btn.tag);
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
