//
//  TaoOrderCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "TaoOrderCell.h"

@implementation TaoOrderCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)loadCell:(OrderModel *)model
{
    _orderNumLabel.text = model.trade_id;
    [_productImage sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    _infoLabel.text = model.title;
    _infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _infoLabel.numberOfLines = 0;
    
    _moneyLabel.text = [NSString stringWithFormat:@"%ld元",model.fanli];
    _timeLabel.text = [NSString stringWithFormat:@"返利时间：%@",model.time];
}
@end
