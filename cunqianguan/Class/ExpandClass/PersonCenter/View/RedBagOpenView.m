//
//  RedBagOpenView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "RedBagOpenView.h"

@implementation RedBagOpenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(RedBagOpenView *)initBagOpenView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    RedBagOpenView *redBagOpenView = nil;
    if ([nibs count]) {
        redBagOpenView = [nibs objectAtIndex:0];
        [redBagOpenView setUpView];
    }
    return redBagOpenView;
}

-(void)setUpView
{
    self.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.5];
    NSString *cashText = _cashLabel.text;
    if (cashText.length > 0) {
        [self refreshView:[cashText floatValue]];
    }
}

- (IBAction)closeAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(closeOpenView)]) {
        [_delegate closeOpenView];
    }
}

- (IBAction)inviteAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(inviteFriend)]) {
        [_delegate inviteFriend];
    }
}

-(void)refreshView:(CGFloat)cash
{
    NSString *cashText = [NSString stringWithFormat:@"%.2f元",cash];
    NSMutableAttributedString *cashStr = [[NSMutableAttributedString alloc] initWithString:cashText];
    [cashStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(cashText.length - 1,1)];
    _cashLabel.attributedText = cashStr;
    
    _successLabel.text = [NSString stringWithFormat:@"成功领取%.2f元红包奖励！",cash];

}
@end
