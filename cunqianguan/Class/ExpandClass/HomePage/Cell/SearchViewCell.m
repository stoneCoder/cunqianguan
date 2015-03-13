//
//  SearchViewCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/13.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "SearchViewCell.h"

@implementation SearchViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadDataWithArray:(NSArray *)data
{
    _infoLabel.text = data[0];
    _tipLable.text = [NSString stringWithFormat:@"约%@个宝贝",data[1]];
    _tipLable.hidden = NO;
    _clearBtn.hidden = YES;
}

-(void)loadDataWithText:(NSString *)text
{
    _infoLabel.text = text;
    _tipLable.hidden = YES;
    _clearBtn.hidden = NO;
}

- (IBAction)clearAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(deleteAction:)]) {
        [_delegate deleteAction:self];
    }
}


@end
