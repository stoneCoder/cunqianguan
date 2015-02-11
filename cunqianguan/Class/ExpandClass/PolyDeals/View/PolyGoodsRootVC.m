//
//  PolyGoodsRootVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyGoodsRootVC.h"
#import "PolyGoodsDetailVC.h"

@interface PolyGoodsRootVC ()

@end

@implementation PolyGoodsRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpTableView
{
    _actionBtn.layer.cornerRadius = 2;
    _actionBtn.layer.masksToBounds = YES;
    _bottomView.layer.shadowOpacity = 0.1;
    PolyGoodsDetailVC *polyGoodsDetailVC = [[PolyGoodsDetailVC alloc] init];
    [self addChildViewController:polyGoodsDetailVC];
    [self.view insertSubview:polyGoodsDetailVC.view belowSubview:_bottomView];
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
