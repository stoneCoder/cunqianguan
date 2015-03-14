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
    _orderNumLabel.text = [NSString stringWithFormat:@"订单号：%@",model.trade_id];
    [_productImage sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"load_default"]];
    _infoLabel.text = model.title;
    _infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _infoLabel.numberOfLines = 0;
    
    NSString *moneyText = [NSString stringWithFormat:@"返%ld集分宝",(long)model.fanli];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:moneyText];
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x2db8ad) range:NSMakeRange(1,moneyText.length - 4)];
    _moneyLabel.attributedText = str;
    
    _timeLabel.text = [NSString stringWithFormat:@"%@",model.time];
}
@end
