//
//  MsgInfoCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/4/23.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "SWTableViewCell.h"
#import "MsgModel.h"
@interface MsgInfoCell : SWTableViewCell
@property (strong, nonatomic) UIButton *tipButton;
@property (strong, nonatomic) UIImageView *tipImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIView *separatorView;
-(void)loadCell:(MsgModel *)model;
@end
