//
//  PolyDetailHeaderView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyDetailHeaderView.h"

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
    _nameView.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.3];
}
@end
