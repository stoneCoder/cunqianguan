//
//  AliTransfersView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"

@interface AliTransfersView : BaseView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@property (weak, nonatomic) IBOutlet UILabel *aliNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *canMoneyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutlet UIButton *cancleBtn;
@property (strong, nonatomic) IBOutlet UIButton *subBtn;


+(AliTransfersView *)transfersView;
-(void)showView:(NSInteger)type; //1 现金提现到支付宝 2 集分宝提现到支付宝
-(void)hideView;
@end
