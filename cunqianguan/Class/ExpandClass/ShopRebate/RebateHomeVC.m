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
    self.view.backgroundColor = UIColorFromRGB(0xECECEC);
    NSDictionary *imageDic = @{@"images":@[@"share",@"jiaoya",@"taobao_btn"],@"imageshover":@[@"share_hover",@"jiaoya_hover",@"taobao_btn_hover"]};
    //[self setRigthBarWithImageDic:];
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

@end
