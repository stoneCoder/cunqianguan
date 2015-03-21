//
//  MenuCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/20.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MenuCell.h"
#import "BaseUtil.h"

@implementation MenuCell

- (void)awakeFromNib {
    // Initialization code
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[BaseUtil imageWithColor:UIColorFromRGB(0xececec)]];
}

@end
