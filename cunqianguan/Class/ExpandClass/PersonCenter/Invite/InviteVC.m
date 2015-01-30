//
//  InviteVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/30.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "InviteVC.h"
#import "InviteRewardVC.h"

@interface InviteVC ()

@end

@implementation InviteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _pointLabel.text = @"注：当用户通过您的邀请链接访问保鲜网后，只要在7天内注册，均为有效。";
    _pointLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _pointLabel.numberOfLines = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)watchInviteReword:(id)sender
{
    InviteRewardVC *inviteRewardVC = [[InviteRewardVC alloc] init];
    inviteRewardVC.leftTitle = @"查看邀请奖励";
    [self.navigationController pushViewController:inviteRewardVC animated:YES];
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
