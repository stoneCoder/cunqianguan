//
//  AccountCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "AccountCell.h"

@implementation AccountCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    // Initialization code
    _cellBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    self.contentView.backgroundColor = UIColorFromRGB(0xececec);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)btnAction:(id)sender
{
    if (_cellDelegate && [_cellDelegate respondsToSelector:@selector(btnAction:)]) {
        [_cellDelegate btnAction:self];
    }
}

@end
