//
//  PolyDetailHeaderView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyDetailHeaderView.h"
#import "BaseUtil.h"
#import "UIImage+Resize.h"
@implementation PolyDetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(PolyDetailHeaderView *)headerView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    PolyDetailHeaderView *polyDetailHeaderView = nil;
    if ([nibs count]) {
        polyDetailHeaderView = [nibs objectAtIndex:0];
        [polyDetailHeaderView setUpView];
    }
    return polyDetailHeaderView;
}

-(void)setUpView
{
    _nameView.backgroundColor = [UIColor whiteColor];
    _scrollView.scrollEnabled = NO;
}

-(void)loadData:(JYHDetailModel *)model
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    CGRect frame = _scrollView.frame;
    frame.size.width = SCREEN_WIDTH;
    imageView.frame = frame;
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.image = [image imageByScalingAndCroppingForSize:imageView.frame.size];
    }];
    [_scrollView insertSubview:imageView belowSubview:_nameView];
    
    
    _productTitle.text = model.title;
    
    NSString *priceText = [NSString stringWithFormat:@"￥%.2f",model.price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceText];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0,1)];
    _priceLabel.attributedText = str;
    
    NSString *oldPriceText = [NSString stringWithFormat:@"￥%.2f",model.price_old];
    NSMutableAttributedString *oldStr = [[NSMutableAttributedString alloc] initWithString:oldPriceText];
    [oldStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, oldPriceText.length)];
    _oldPriceLabel.attributedText = oldStr;
    
    if (model.attr.count > 0) {
        UIFont *font = [UIFont systemFontOfSize:10.0f];
        CGFloat heigth = _titleView.frame.size.height/2 - 5;
        for (int i = 0; i < model.attr.count; i++) {
            JYHAttrModel *attrModel  = model.attr[i];
            NSString *btnTitle = attrModel.name;
            CGFloat width = [BaseUtil getWidthByString:btnTitle font:font allheight:heigth andMaxWidth:100];
            CGRect frame = CGRectMake(SCREEN_WIDTH - 20  - width, _titleView.frame.size.height/2 - 10, width + 8, heigth);
            UIButton *btn = [[UIButton alloc] initWithFrame:frame];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:btnTitle forState:UIControlStateNormal];
            btn.titleLabel.font = font;
            
            NSString *titleColor = [self mathColor:attrModel.color];
            if (titleColor) {
                unsigned long red = strtoul([titleColor UTF8String],0,16);
                [btn setTitleColor:UIColorFromRGB(red) forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            
            
            btn.layer.borderWidth = 1;
            NSString *borderColorStr = [self mathColor:attrModel.borderColor];
            if (borderColorStr) {
                unsigned long red = strtoul([borderColorStr UTF8String],0,16);
                 btn.layer.borderColor = UIColorFromRGB(red).CGColor;
            }else{
                btn.layer.borderColor = [UIColor redColor].CGColor;
            }
            [_titleView addSubview:btn];
        }
    }
}

-(NSString *)mathColor:(NSString *)str
{
    NSString *colorStr = @"";
    NSRange range = [str rangeOfString:@"#"];
    if (range.length > 0) {
        colorStr = [NSString stringWithFormat:@"0x%@",[str substringFromIndex:1]];
    }
    return colorStr;
}
@end
