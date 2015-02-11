//
//  BankTransfersView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"

@interface BankTransfersView : BaseView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@property (weak, nonatomic) IBOutlet UIView *contentView;
+(BankTransfersView *)transfersView;
-(void)showView;
-(void)hideView;
@end
