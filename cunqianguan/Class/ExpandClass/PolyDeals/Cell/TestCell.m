//
//  TestCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "TestCell.h"
@implementation TestCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = [[UIImageView alloc] init];
        _image.backgroundColor = [UIColor redColor];
        [self addSubview:_image];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor orangeColor];
        _titleLabel.numberOfLines = 1;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_titleLabel];
        
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:_priceLabel];
        
        
        _grabLabel = [[UILabel alloc] init];
        _grabLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:_grabLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH/2 - 15);
        make.height.mas_equalTo(_image.mas_width);
        
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(0);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_image.mas_bottom).with.offset(0);
        make.left.equalTo(_image.mas_left).with.offset(5);
        make.right.equalTo(_image.mas_right).with.offset(5);
        make.height.mas_equalTo(29);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(0);
        make.left.equalTo(_titleLabel.mas_left).with.offset(0);
        make.height.mas_equalTo(15);
    }];
    
    [_grabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(5);
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(0);
    }];
}

-(void)loadCell:(JYHModel *)model withType:(NSInteger)type
{
    [_image sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"load_default"]];
    
    _grabLabel.text = [NSString stringWithFormat:@"%ld人在抢",(long)model.qcount];
    _titleLabel.text = model.title;
    
    NSString *priceText = [NSString stringWithFormat:@"￥%.2f",model.price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceText];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:10.0f] range:NSMakeRange(0,1)];
    _priceLabel.attributedText = str;
}
@end
