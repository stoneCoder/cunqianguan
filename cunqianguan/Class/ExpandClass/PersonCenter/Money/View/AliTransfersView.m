//
//  AliTransfersView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "AliTransfersView.h"

@implementation AliTransfersView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(AliTransfersView *)transfersView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    AliTransfersView *aliTransfersView = nil;
    if ([nibs count]) {
        aliTransfersView = [nibs objectAtIndex:0];
        [aliTransfersView setUpView];
    }
    return aliTransfersView;
}

-(void)setUpView
{
    self.hidden = YES;
    self.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.3];
}
- (IBAction)cancleAction:(id)sender
{
    [self hideView];
}

-(void)showView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.hidden = NO;
    }];
}

-(void)hideView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.hidden = YES;
    } completion:^(BOOL finished) {
        //[self removeFromSuperview];
    }];
}
@end
