//
//  BankTransfersView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"
#import "BankModel.h"
@protocol BankTransfersViewDelegate<NSObject>
-(void)cashToBank:(NSString *)money pwd:(NSString *)pwd;
@end
@interface BankTransfersView : BaseView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UIButton *cancleBtn;
@property (strong, nonatomic) IBOutlet UIButton *subBtn;
@property (strong, nonatomic) id<BankTransfersViewDelegate> delegate;

+(BankTransfersView *)transfersView;
-(void)showViewWithModel:(BankModel *)bankModel;
-(void)hideView;
@end
