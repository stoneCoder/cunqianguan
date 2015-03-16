//
//  AllCheckView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/7.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "AllCheckView.h"

@implementation AllCheckView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(AllCheckView *)init
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    AllCheckView *allCheckView = nil;
    if ([nibs count]) {
        allCheckView = [nibs objectAtIndex:0];
    }
    return allCheckView;
}

- (IBAction)checkAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(allCheckAction)]) {
        [_delegate allCheckAction];
    }
}

- (IBAction)cancleAction:(id)sender
{
    _checkBtn.selected = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(cancleAction)]) {
        [_delegate cancleAction];
    }
}

- (IBAction)submitAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(submitAction)]) {
        [_delegate submitAction];
    }
}
@end
