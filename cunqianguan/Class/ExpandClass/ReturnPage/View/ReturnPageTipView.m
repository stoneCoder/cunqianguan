//
//  ReturnPageTipView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/18.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ReturnPageTipView.h"
#import "BaseUtil.h"
@implementation ReturnPageTipView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+(ReturnPageTipView *)tipView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    ReturnPageTipView *returnPageTipView = nil;
    if ([nibs count]) {
        returnPageTipView = [nibs objectAtIndex:0];
        [returnPageTipView setUpView];
    }
    return returnPageTipView;
}

-(void)setUpView
{
    [_tipBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x2db8ad)] forState:UIControlStateNormal];
    [_tipBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x179a90)] forState:UIControlStateHighlighted];
    _tipBtn.layer.cornerRadius = 5.0f;
    _tipBtn.layer.masksToBounds = YES;
}

- (IBAction)btnAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickAction)]) {
        [_delegate clickAction];
    }
}
@end
