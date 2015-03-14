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

-(void)loadCellWith:(InviteModel *)model
{
    _timeLabel.text = model.username;
    
    NSString *titleStr = @"";
    int value = [model.remoney intValue];
    if (value < 1) {
       titleStr = @"返利<1元";
    } else if (value > 1 && value < 100) {
        titleStr = @"返利<100元";
    } else if (value > 100 && value < 500) {
        titleStr = @"返利<500元";
    } else if (value > 500) {
        titleStr = @"返利>500元";
    }
    _titleLabel.text = titleStr;
    
    NSString *infoText = [NSString stringWithFormat:@"已奖励%@元",model.mmoney];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:infoText];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(infoText.length - 2,infoText.length - 3)];
    _infoLabel.attributedText = str;
}

@end
