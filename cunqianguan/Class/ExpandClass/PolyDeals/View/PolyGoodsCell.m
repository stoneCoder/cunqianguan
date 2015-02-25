//
//  PolyGoodsCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/23.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyGoodsCell.h"

@implementation PolyGoodsCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)loadCell:(JYHModel *)jyhModel
{
    [_productImage sd_setImageWithURL:[NSURL URLWithString:jyhModel.pic_url]];
    _qLabel.text = [NSString stringWithFormat:@"%ld人在抢",(long)jyhModel.qcount];
    
    _title.text = jyhModel.title;
    
    NSString *priceText = [NSString stringWithFormat:@"￥%.2f",jyhModel.price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceText];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0,1)];
    _priceLabel.attributedText = str;
}
@end
