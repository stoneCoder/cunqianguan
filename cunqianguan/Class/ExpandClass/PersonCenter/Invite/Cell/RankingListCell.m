//
//  RankingListCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "RankingListCell.h"

@implementation RankingListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadCell:(RankingModel *)model andIndex:(NSInteger)index
{
    _nameLabel.text = model.username;
    _priceLabel.text = [NSString stringWithFormat:@"%ld元",(long)model.rewardMoney];
    if (index > 3) {
        _rankingTag.selected = YES;
    }
    [_rankingTag setTitle:[NSString stringWithFormat:@"%ld",(long)index] forState:UIControlStateNormal];
}
@end
