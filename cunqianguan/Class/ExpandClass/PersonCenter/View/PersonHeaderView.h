//
//  PersonHeaderView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonInfo.h"
#import "PopTipView.h"
@protocol PersonHeaderDelegate<NSObject>
-(void)btnAction:(NSInteger)tag;
-(void)tapHeadImage;
@end
@interface PersonHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UIImageView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *progressBgView;
@property (weak, nonatomic) IBOutlet UIImageView *pointImageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *collectLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *headBgView;
@property (weak, nonatomic) IBOutlet UIImageView *vipImage;

@property (strong, nonatomic) id<PersonHeaderDelegate> delegate;
+(PersonHeaderView *)headerView;
-(void)loadView:(PersonInfo *)info;
@end
