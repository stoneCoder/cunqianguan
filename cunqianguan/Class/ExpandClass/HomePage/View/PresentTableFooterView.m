//
//  PresentTableFooterView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/18.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PresentTableFooterView.h"

@implementation PresentTableFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(PresentTableFooterView *)footView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    PresentTableFooterView *presentTableFooterView = nil;
    if ([nibs count]) {
        presentTableFooterView = [nibs objectAtIndex:0];
        [presentTableFooterView setUpView];
    }
    return presentTableFooterView;
}

-(void)setUpView
{
    _firstLabel.numberOfLines = 0;
    _firstLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    _secondLabel.numberOfLines = 0;
    _secondLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    _thirdLabel.numberOfLines = 0;
    _thirdLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    _firstView.layer.cornerRadius = 5.0f;
    _firstView.layer.masksToBounds = YES;
    
    _secondView.layer.cornerRadius = 5.0f;
    _secondView.layer.masksToBounds = YES;
    
    _thirdView.layer.cornerRadius = 5.0f;
    _thirdView.layer.masksToBounds = YES;
}
@end
