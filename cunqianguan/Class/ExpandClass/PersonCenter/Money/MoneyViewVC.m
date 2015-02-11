//
//  MoneyViewVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MoneyViewVC.h"
#import "AliTransfersView.h"
#import "BankTransfersView.h"
@interface MoneyViewVC ()
{
    AliTransfersView *_aliTransfersView;
    BankTransfersView *_bankTransfersView;
}

@end

@implementation MoneyViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self refreshViewWithType:_type];
    
    [self createAliView];
    [self createBankView];
    
}

-(void)createAliView
{
    if (!_aliTransfersView) {
        _aliTransfersView = [AliTransfersView transfersView];
        [self.view addSubview:_aliTransfersView];
    }
}

-(void)createBankView
{
    if (!_bankTransfersView) {
        _bankTransfersView = [BankTransfersView transfersView];
        [self.view addSubview:_bankTransfersView];
    }
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
-(void)refreshViewWithType:(ViewType)viewType
{
    //_cashView.backgroundColor = UIColorFromRGB(0xececec);
    switch (viewType) {
        case ViewTypeWithCash:
            _firstLabel.text = @"现金收入";
            _secondLabel.text = @"待返利";
            _cashView.hidden = NO;
            _integralBtn.hidden = YES;
            _taoBtn.hidden = YES;
            break;
        case ViewTypeWithTao:
            _firstLabel.text = @"淘宝集分宝收入";
            _secondLabel.text = @"待返利";
            _cashView.hidden = YES;
            _integralBtn.hidden = YES;
            _taoBtn.hidden = NO;
            break;
        case ViewTypeWithIntegral:
            _firstLabel.text = @"积分收入";
            _secondLabel.text = @"待返利";
            _cashView.hidden = YES;
            _integralBtn.hidden = NO;
            _taoBtn.hidden = YES;
            break;
    }
}
- (IBAction)transForBank:(id)sender
{
    [self createBankView];
    [_bankTransfersView showView];
}
- (IBAction)transForAlipay:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self createAliView];
    switch (btn.tag) {
        case 1000:
            /*现金收入*/
            [_aliTransfersView showView];
            break;
        case 1001:
            /*集分宝收入*/
            [_aliTransfersView showView];
            break;
    }
}

@end
