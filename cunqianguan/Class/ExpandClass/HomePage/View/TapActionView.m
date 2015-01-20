//
//  TapActionView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "TapActionView.h"

@implementation TapActionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(TapActionView *)init
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    TapActionView *tapActionView = nil;
    if ([nibs count]) {
        tapActionView = [nibs objectAtIndex:0];
    }
    return tapActionView;
}


@end
