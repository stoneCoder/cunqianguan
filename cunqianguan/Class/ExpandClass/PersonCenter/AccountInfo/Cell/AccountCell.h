//
//  AccountCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "SWTableViewCell.h"
@class AccountCell;
@protocol AccountCellDelegate<NSObject>
-(void)btnAction:(AccountCell *)cell;
@end
@interface AccountCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *infoImage;

@property (strong,nonatomic) id<AccountCellDelegate> cellDelegate;

@end
