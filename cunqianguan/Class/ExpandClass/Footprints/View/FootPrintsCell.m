//
//  FootPrintsCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "FootPrintsCell.h"

@implementation FootPrintsCell

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
    
    // Configure the view for the selected state
}

-(void)loadCell:(FootModel *)model
{
    [_productImage sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    _titleLable.text = model.title;
    
    NSString *priceText = [NSString stringWithFormat:@"￥%.2f",model.price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceText];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14.0f] range:NSMakeRange(0,1)];
    _priceLabel.attributedText = str;
    
    NSString *oldPriceText = [NSString stringWithFormat:@"%.2f",model.priceOld];
    NSMutableAttributedString *oldStr = [[NSMutableAttributedString alloc] initWithString:oldPriceText];
    [oldStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, oldPriceText.length)];
    _oldPriceLabel.attributedText = oldStr;
    
    NSString *fanliText = [NSString stringWithFormat:@"购买后最高返利%ld个集分宝",(long)model.commissionRate];
    if(model.commissionRate == 0){
        fanliText = @"无返利";
    }
    NSMutableAttributedString *fanliStr = [[NSMutableAttributedString alloc] initWithString:fanliText];
    if (model.commissionRate  > 0 ) {
        [fanliStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x2EB7AD) range:NSMakeRange(7, fanliText.length - 7)];
    }
    _fanliLabel.attributedText = fanliStr;
    
    _timeLabel.text = [NSString stringWithFormat:@"%@",model.date];
}
@end
