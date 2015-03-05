//
//  AccountEditVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseVC.h"
#import "BankModel.h"
typedef NS_ENUM(NSInteger, ViewType) {
    ViewTypeWithAipay,
    ViewTypeWithBank,
};
@interface AccountEditVC : BaseVC
@property (weak, nonatomic) IBOutlet UIView *AlipayView;
@property (weak, nonatomic) IBOutlet UIView *bankCardView;
@property (weak, nonatomic) IBOutlet UITextField *aliPayText;
@property (weak, nonatomic) IBOutlet UITextField *aliPayPwdText;
@property (weak, nonatomic) IBOutlet UITextField *bankNameText;
@property (weak, nonatomic) IBOutlet UITextField *bankCityText;
@property (weak, nonatomic) IBOutlet UITextField *bankText;
@property (weak, nonatomic) IBOutlet UITextField *bankNumText;
@property (weak, nonatomic) IBOutlet UITextField *bankPwdText;

@property (assign,nonatomic) NSInteger viewType;
@property (strong, nonatomic) BankModel *model;
@end
