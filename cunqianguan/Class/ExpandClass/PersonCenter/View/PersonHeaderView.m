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
    _headImageView.clipsToBounds = YES;
    _headImageView.userInteractionEnabled = YES;
    [_headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateInfo:)]];
    
    _pointImageView.layer.cornerRadius = _pointImageView.frame.size.width/2;
    _pointImageView.layer.masksToBounds = YES;
}
- (IBAction)btnAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (_delegate && [_delegate respondsToSelector:@selector(btnAction:)]) {
        [_delegate btnAction:btn.tag];
    }
}

-(void)updateInfo:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(tapHeadImage)]) {
        [_delegate tapHeadImage];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end