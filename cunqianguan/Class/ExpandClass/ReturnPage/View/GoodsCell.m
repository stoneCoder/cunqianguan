//
//  GoodsCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/22.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "GoodsCell.h"

@implementation GoodsCell

- (void)awakeFromNib {
    // Initialization code
    _titleLabel.numberOfLines = 2;
    _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
}

-(void)loadCell:(MongoModel *)mongoModel
{
    [_productImage sd_setImageWithURL:[NSURL URLWithString:mongoModel.pic_url] placeholderImage:[UIImage imageNamed:@"load_default"]];
    
    _titleLabel.text = mongoModel.title;
    
    NSString *priceText = [NSString stringWithFormat:@"￥%.2f",mongoModel.price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceText];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0,1)];
    _priceLabel.attributedText = str;
    
    NSString *oldPriceText = [NSString stringWithFormat:@"￥%.2f",mongoModel.price_old];
    NSMutableAttributedString *oldStr = [[NSMutableAttributedString alloc] initWithString:oldPriceText];
    [oldStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, oldPriceText.length)];
    _oldPriceLabel.attributedText = oldStr;
    
    _saleLabel.text = [NSString stringWithFormat:@"销量：%ld",(long)mongoModel.volume];
    
    _commissionRateLabel.text = [NSString stringWithFormat:@"返%ld%%",(long)mongoModel.commission_rate];
}
@end
