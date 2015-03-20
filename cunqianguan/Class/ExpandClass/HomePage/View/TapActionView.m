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
        [tapActionView setUpTapAction];
    }
    return tapActionView;
}

-(void)setUpTapAction
{
    _tipImage.layer.cornerRadius = 2.0f;

    [_taobaoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    [_zujiView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    [_juyouhuiView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    [_fanligouView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    [_duihuanView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    [_shopView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    [_myView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
}

-(void)tapView:(UITapGestureRecognizer *)tap
{
    UIView *tapView = (UIView *)tap.view;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapViewAction:)]) {
        [self.delegate tapViewAction:tapView];
    }
}

@end
