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
    
    _checkmarkView = [[CheckmarkView alloc] initWithFrame:CGRectMake(10, 10, 24.0, 24.0)];
    _checkmarkView.autoresizingMask = UIViewAutoresizingNone;
    _checkmarkView.hidden = YES;
    _checkmarkView.assetCollectionCell = self;
    [self addSubview:_checkmarkView];
}

-(void)loadCell:(CollectModel *)model
{
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    
    _titleLabel.text = model.title;
    
    //NSString *priceText = [NSString stringWithFormat:@"￥%.2f",model.price];
    //NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceText];
    //[str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:10.0f] range:NSMakeRange(0,1)];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",model.price];
    
    NSString *oldPriceText = [NSString stringWithFormat:@"￥%.2f",model.priceOld];
    NSMutableAttributedString *oldStr = [[NSMutableAttributedString alloc] initWithString:oldPriceText];
    [oldStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, oldPriceText.length)];
    _oldPriceLabel.attributedText = oldStr;
    
    _saleNumLabel.text = [NSString stringWithFormat:@"销量：%ld",(long)model.volume];
    
    _fanliLabel.text = [NSString stringWithFormat:@"返利：%ld%%",(long)model.commissionRate];
}
@end
