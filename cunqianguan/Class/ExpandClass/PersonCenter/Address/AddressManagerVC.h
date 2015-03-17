//
//  AddressManagerVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseVC.h"

@interface AddressManagerVC : BaseVC
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UIView *emptyView;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UITextField *receiveText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeText;
@property (weak, nonatomic) IBOutlet UITextField *qqCodeText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@property (assign, nonatomic) BOOL isExChange;
@property (strong, nonatomic) NSString *productId;

@end
