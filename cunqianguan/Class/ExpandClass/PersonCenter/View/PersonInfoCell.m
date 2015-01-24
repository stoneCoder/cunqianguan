//
//  PersonInfoCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PersonInfoCell.h"

@implementation PersonInfoCell

- (void)awakeFromNib {
    // Initialization code
    _poingImage.layer.cornerRadius = _poingImage.frame.size.width/2;
    _poingImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
