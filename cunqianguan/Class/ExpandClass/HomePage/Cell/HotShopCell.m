//
//  HotShopCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/5.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HotShopCell.h"
#import "UIImage+Resize.h"
#import "BaseUtil.h"

@implementation HotShopCell

- (void)awakeFromNib {
    // Initialization code
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[BaseUtil imageWithColor:UIColorFromRGB(0xececec)]];
}

-(void)loadCell:(HotShopModel *)model
{
    if ([model.mallName isEqualToString:@"天猫商城"] || [model.mallName isEqualToString:@"天天特价"] || [model.mallName isEqualToString:@"淘宝旅行"]) {
        _logoImageView.image = [UIImage imageNamed:model.logo];
    }else{
        [_logoImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //_logoImageView.image = [image scaleToSize:_logoImageView.frame.size];
        }];
         _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    NSString *priceText = [NSString stringWithFormat:@"最高返利%@",model.fanli];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:priceText];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,priceText.length - 4)];
    _infoLabel.attributedText = str;
}

@end
