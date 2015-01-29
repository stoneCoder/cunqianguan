//
//  MoneyViewVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MoneyViewVC.h"
@interface MoneyViewVC ()

@end

@implementation MoneyViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self refreshViewWithType:_type];
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
    _cashView.backgroundColor = UIColorFromRGB(0xececec);
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
            _integralBtn.hidden = YES;
            _taoBtn.hidden = NO;
            break;
        default:
            break;
    }
}

@end
