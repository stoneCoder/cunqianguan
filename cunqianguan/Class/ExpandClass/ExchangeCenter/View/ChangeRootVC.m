//
//  ChangeRootVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ChangeRootVC.h"
#import "ChangeProductVC.h"

#import "ExChangeConnect.h"
#import "BaseConnect.h"

#import "ExChangeDetailModel.h"
#import "PersonInfo.h"
@interface ChangeRootVC ()
{
    ChangeProductVC *_changeProductVC;
}

@end

@implementation ChangeRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpTableView];
    [self loadData:_model.productId];
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
    _changeProductVC = [[ChangeProductVC alloc] init];
    [self addChildViewController:_changeProductVC];
    [self.view insertSubview:_changeProductVC.view belowSubview:_bottomView];
}

-(void)loadData:(NSString *)productId
{
    [self showHUD:DATA_LOAD];
    [[ExChangeConnect sharedExChangeConnect] exchangeGoodsDetail:productId success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            NSDictionary *data = [dic objectForKey:@"data"];
            ExChangeDetailModel *detailModel = [[ExChangeDetailModel alloc] initWithDictionary:data error:nil];
            [_changeProductVC reloadView:_model andDetail:detailModel];
            [self refreshBottomView];
            _infoLabel.text = [NSString stringWithFormat:@"剩余%ld件",(long)_model.in_stock];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

-(void)refreshBottomView
{
    PersonInfo *info = [PersonInfo sharedPersonInfo];
    NSInteger inSock = _model.in_stock;
    if (inSock == 0) {
        _actionBtn.backgroundColor = [UIColor redColor];
        [_actionBtn setTitle:@"抢光了" forState:UIControlStateNormal];
        _actionBtn.userInteractionEnabled = NO;
    }else if (info.pointSite < _model.point){
        _actionBtn.backgroundColor = [UIColor grayColor];
        [_actionBtn setTitle:@"积分不足" forState:UIControlStateNormal];
        _actionBtn.userInteractionEnabled = NO;
    }
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
