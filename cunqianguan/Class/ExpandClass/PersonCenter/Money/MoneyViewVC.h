//
//  MoneyViewVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseVC.h"
typedef NS_ENUM(NSInteger, ViewType) {
    ViewTypeWithCash,
    ViewTypeWithTao,
    ViewTypeWithIntegral,
};
@interface MoneyViewVC : BaseVC
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondNumLabel;
@property (weak, nonatomic) IBOutlet UIView *cashView;
@property (weak, nonatomic) IBOutlet UIButton *integralBtn;
@property (weak, nonatomic) IBOutlet UIButton *taoBtn;
@property (strong, nonatomic) IBOutlet UIButton *withdrawBankBtn;
@property (strong, nonatomic) IBOutlet UIButton *withdrawTaoBtn;

@property (weak, nonatomic) IBOutlet UIImageView *bottomView;

@property (assign,nonatomic) NSInteger type;
@end
