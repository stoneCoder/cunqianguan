//
//  TapActionView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "TapActionView.h"
#import "BaseUtil.h"
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
    _tipImage.layer.cornerRadius = 3.0f;

    [_taobaoView setNormalBgColor:UIColorFromRGB(0xffa82b) andHighlightedBgColor:UIColorFromRGB(0xed961a)];
    [_zujiView setNormalBgColor:UIColorFromRGB(0x24cde6) andHighlightedBgColor:UIColorFromRGB(0x10b5cd)];
    [_juyouhuiView setNormalBgColor:UIColorFromRGB(0xff5c5c) andHighlightedBgColor:UIColorFromRGB(0xe83434)];
    [_fanligouView setNormalBgColor:UIColorFromRGB(0x2edcce) andHighlightedBgColor:UIColorFromRGB(0x12c2b3)];
    [_duihuanView setNormalBgColor:UIColorFromRGB(0x61e094) andHighlightedBgColor:UIColorFromRGB(0x38c470)];
    [_shopView setNormalBgColor:UIColorFromRGB(0x5ac5e0) andHighlightedBgColor:UIColorFromRGB(0x33a5c2)];
    [_myView setNormalBgColor:UIColorFromRGB(0x8eb4ee) andHighlightedBgColor:UIColorFromRGB(0x5f8bcd)];
    
    
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
