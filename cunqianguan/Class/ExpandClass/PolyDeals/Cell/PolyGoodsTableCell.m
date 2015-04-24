//
//  PolyGoodsTableCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/4/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyGoodsTableCell.h"
@implementation PolyGoodsTableCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_productImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH/2 - 20);
        //make.height.mas_equalTo(@((SCREEN_WIDTH/2 - 20)/1.52174));
    }];
    
    _titleLabel.numberOfLines = 2;
    _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    _goTmallBtn.layer.cornerRadius = 3.0f;
    _goTmallBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadData:(TeJiaModel *)model
{
    [_productImage sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"tejia_load_more"]];
    
    _titleLabel.text = model.title;
    
    NSString *priceText = [NSString stringWithFormat:@"￥%.2f",model.price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceText];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:10.0f] range:NSMakeRange(0,1)];
    _priceLabel.attributedText = str;
    
    NSString *oldPriceText = [NSString stringWithFormat:@"￥%.2f",model.priceOld];
    NSMutableAttributedString *oldStr = [[NSMutableAttributedString alloc] initWithString:oldPriceText];
    [oldStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, oldPriceText.length)];
    _oldPriceLabel.attributedText = oldStr;
    
   
   _isNewBtn.hidden = model.isNew;

}
@end
