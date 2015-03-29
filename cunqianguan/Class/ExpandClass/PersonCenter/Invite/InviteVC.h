//
//  InviteVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/30.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseVC.h"

@interface InviteVC : BaseVC
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UILabel *totelMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totelInviteLabel;
@property (strong, nonatomic) IBOutlet UIButton *inviteBtn;
@property (strong, nonatomic) IBOutlet UIButton *watchInviteBtn;

@end
