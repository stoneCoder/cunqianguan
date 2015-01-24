//
//  PersonHeaderView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PersonHeaderView.h"

@implementation PersonHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(PersonHeaderView *)headerView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    PersonHeaderView *personHeaderView = nil;
    if ([nibs count]) {
        personHeaderView = [nibs objectAtIndex:0];
        [personHeaderView setUpView];
    }
    return personHeaderView;
}

-(void)setUpView
{
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    _headImageView.layer.masksToBounds = YES;
    
    _pointImageView.layer.cornerRadius = _pointImageView.frame.size.width/2;
    _pointImageView.layer.masksToBounds = YES;
}

@end
