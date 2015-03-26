//
//  RedBagView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "RedBagView.h"

@implementation RedBagView

+(RedBagView *)initBagView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    RedBagView *redBagView = nil;
    if ([nibs count]) {
        redBagView = [nibs objectAtIndex:0];
        [redBagView setUpView];
    }
    return redBagView;
}

-(void)setUpView
{
    self.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.5];
    [_tapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openRedBag:)]];
}

- (IBAction)closeAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(closeRedBagView)]) {
        [_delegate closeRedBagView];
    }
}

-(void)openRedBag:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(tapToOpenRedBag)]) {
        [_delegate tapToOpenRedBag];
    }
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (CGRectContainsPoint(_closeBtn.frame, point)) {
        return _closeBtn;
    }else if(CGRectContainsPoint(_tapView.frame, point)){
        return _tapView;
    }else{
        return self;
    }
}


-(void)hideView
{
    self.hidden = YES;
}
@end
