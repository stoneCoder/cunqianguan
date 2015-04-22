//
//  ShopOrderCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ShopOrderCell.h"
#import "UIImage+Resize.h"
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
    self.contentView.backgroundColor = UIColorFromRGB(0xececec);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)loadCell:(OrderModel *)model
{
    NSString *typeStr;
    NSString *fanlStr;
    switch (model.status) {
        case 0:
            typeStr = @"订单失效";
            _typeLabel.textColor = UIColorFromRGB(0x969696);
            _orderNumLabel.textColor = UIColorFromRGB(0x969696);
            fanlStr = @"订单已失效";
            break;
        case 1:
            typeStr = @"已返利";
            fanlStr = [NSString stringWithFormat:@"已返利：%.2f元",model.fanli];
            _typeLabel.textColor = UIColorFromRGB(0x2db8ad);
            _orderNumLabel.textColor = UIColorFromRGB(0x3c3c3c);
            break;
        case 2:
            typeStr = @"待返利";
            fanlStr = [NSString stringWithFormat:@"待返利：%.2f元",model.fanli];
            _typeLabel.textColor = UIColorFromRGB(0xff9c00);
            _orderNumLabel.textColor = UIColorFromRGB(0x3c3c3c);
            break;
    }
    _typeLabel.text = typeStr;
    _orderNumLabel.text = [NSString stringWithFormat:@"订单号：%@",model.trade_id];
    
    [_productImage sd_setImageWithURL:[NSURL URLWithString:model.pic_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _productImage.image = [image resizeImageToSize:_productImage.frame.size resizeMode:enSvResizeAspectFit];
    }];
    _priceLabel.text = [NSString stringWithFormat:@"订单金额：%.2f元",model.pay_price];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:fanlStr];
    if (model.status == 1) {
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x2db8ad) range:NSMakeRange(4,fanlStr.length - 4)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.0f] range:NSMakeRange(4,fanlStr.length - 4)];
    }else if(model.status == 2){
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xff9c00) range:NSMakeRange(4,fanlStr.length - 4)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.0f] range:NSMakeRange(4,fanlStr.length - 4)];
    }
    _moneyLable.attributedText = str;
    _timeLabel.text = [NSString stringWithFormat:@"跟单时间：%@",model.time];

}
@end
