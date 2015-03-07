//
//  MessageInfoCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MessageInfoCell.h"

@implementation MessageInfoCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    // Initialization code
    _infoLabel.numberOfLines = 0;
    _infoLabel.lineBreakMode = NSLineBreakByCharWrapping;
}

 //0 通知 1 公告
-(void)loadCell:(MsgModel *)model
{
    _infoLabel.text = model.contents;
    if (model.types == 0) {
        _tipImage.image = [UIImage imageNamed:@"msg_tip_noti"];
    }else if (model.types == 1) {
        _tipImage.image = [UIImage imageNamed:@"msg_tip_post"];
    }
}
@end
