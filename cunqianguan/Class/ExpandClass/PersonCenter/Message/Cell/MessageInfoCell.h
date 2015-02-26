//
//  MessageInfoCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "SWTableViewCell.h"
#import "MsgModel.h"
@interface MessageInfoCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *tipImage;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
-(void)loadCell:(MsgModel *)model;
@end
