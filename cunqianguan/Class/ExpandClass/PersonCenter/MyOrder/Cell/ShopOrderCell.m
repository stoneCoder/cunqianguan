//
//  ShopOrderCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ShopOrderCell.h"

@implementation ShopOrderCell

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

-(void)loadCell:(OrderModel *)model
{
    NSString *typeStr;
    switch (model.type) {
        case 0:
            typeStr = @"订单失效";
            break;
        case 1:
            typeStr = @"已返利";
            break;
        case 2:
            typeStr = @"待返利";
            break;
    }
    _typeLabel.text = typeStr;
    
    [_productImage sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    _priceLabel.text = [NSString stringWithFormat:@"%.2f元",model.pay_price];
    _moneyLable.text = [NSString stringWithFormat:@"%ld元",model.fanli];
    _timeLabel.text = [NSString stringWithFormat:@"跟单时间：%@",model.time];

}
@end
