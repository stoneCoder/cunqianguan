//
//  LoginVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/20.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseVC.h"
typedef void (^LoginSuccessHandler)(int type);
@interface LoginVC : BaseVC
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIImageView *userimage;
@property (weak, nonatomic) IBOutlet UIImageView *pwdimage;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;


@end
