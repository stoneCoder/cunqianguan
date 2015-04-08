//
//  ExChangeCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/23.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ExChangeCell.h"

@implementation ExChangeCell

- (void)awakeFromNib {
    // Initialization code
    [_productImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((SCREEN_WIDTH - 30)/2);
    }];
}

-(void)loadCell:(ExChangeModel *)model
{
    [_productImage sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"load_default"]];
    
    _titleLabel.text = model.title;
    _pointLabel.text = [NSString stringWithFormat:@"%ld积分",(long)model.point];
    _stockLabel.text = [NSString stringWithFormat:@"剩%ld件",(long)model.in_stock];
    
}
@end
