//
//  MsgSetCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MsgSetCell.h"

@implementation MsgSetCell

- (void)awakeFromNib {
    // Initialization code
    //[_infoLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipToChangeTime)]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)switchAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(tapSwitch:)]) {
        [_delegate tapSwitch:self];
    }
}

//-(void)tipToChangeTime
//{
//    if (_delegate && [_delegate respondsToSelector:@selector(tapTimeAction:)]) {
//        [_delegate tapTimeAction:self];
//    }
//}
@end
