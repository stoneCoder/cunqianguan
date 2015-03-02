//
//  AccountInfoCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "RunningWaterCell.h"

@implementation RunningWaterCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadCell:(RunningWaterModel *)model
{
    _timeLabel.text = [NSString stringWithFormat:@"%@ %@",model.date,model.time];
    
    _titleLabel.text = model.content;
    
    _infoLabel.text = model.status;
}

@end
