//
//  CollectCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/9.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "CollectCell.h"

@implementation CollectCell

- (void)awakeFromNib {
    // Initialization code
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
}

-(void)loadCell:(CollectModel *)model
{
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    
    _titleLabel.text = model.title;
    
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",model.price];
    
    NSString *oldPriceText = [NSString stringWithFormat:@"￥%.2f",model.priceOld];
    NSMutableAttributedString *oldStr = [[NSMutableAttributedString alloc] initWithString:oldPriceText];
    [oldStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, oldPriceText.length)];
    _oldPriceLabel.attributedText = oldStr;
    
    _saleNumLabel.text = [NSString stringWithFormat:@"销量：%ld",(long)model.volume];
    
    _fanliLabel.text = [NSString stringWithFormat:@"返利：%ld%%",(long)model.commissionRate];
}
@end
