//
//  HotShopCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/5.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HotShopCell.h"

@implementation HotShopCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)loadCell:(HotShopModel *)model
{
    [_logoImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    
    NSString *priceText = [NSString stringWithFormat:@"最高返利%@",model.fanli];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceText];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,priceText.length - 4)];
    _infoLabel.attributedText = str;
}

@end
