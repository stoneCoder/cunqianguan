//
//  PolyGoodsCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/23.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyGoodsCell.h"
#import "UIImage+Resize.h"
@implementation PolyGoodsCell

- (void)awakeFromNib {
    // Initialization code
//    [_productImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(self.mas_width);
//        make.height.mas_equalTo(_productImage.mas_width);
//    }];
}

-(void)loadCell:(JYHModel *)model withType:(NSInteger)type
{
    [_productImage sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"load_default"]];
    if (type == 0) {
        _qLabel.text = [NSString stringWithFormat:@"%ld人在抢",(long)model.qcount];
        _hotTipImage.hidden = NO;
    }else{
        switch (model.status) {
            case 3:
                 _qLabel.text = @"未开始";
                break;
            }
    }
    _title.text = model.title;
    
    NSString *priceText = [NSString stringWithFormat:@"￥%.2f",model.price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceText];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:10.0f] range:NSMakeRange(0,1)];
    _priceLabel.attributedText = str;
}


@end
