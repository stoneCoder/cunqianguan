//
//  PersonFooterView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PersonFooterView.h"
#import "TipInfoVC.h"
@implementation PersonFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(PersonFooterView *)footerView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    PersonFooterView *personFooterView = nil;
    if ([nibs count]) {
        personFooterView = [nibs objectAtIndex:0];
        //[tapActionView setUpTapAction];
    }
    return personFooterView;
}
- (IBAction)btnAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(helpInfoClick)]) {
        [_delegate helpInfoClick];
    }
}
- (IBAction)loginOutAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(loginOutClick)]) {
        [_delegate loginOutClick];
    }
}

@end
