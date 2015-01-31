//
//  ProfileCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)awakeFromNib {
    // Initialization code
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    _headImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
