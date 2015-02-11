//
//  BankTransfersView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BankTransfersView.h"

@implementation BankTransfersView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(BankTransfersView *)transfersView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    BankTransfersView *bankTransfersView = nil;
    if ([nibs count]) {
        bankTransfersView = [nibs objectAtIndex:0];
        [bankTransfersView setUpView];
    }
    return bankTransfersView;
}

-(void)setUpView
{
    self.hidden = YES;
    self.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.3];
    _numText.delegate = self;
    _pwdText.delegate = self;
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

-(void)changeViewPath
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    self.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 64);
    [UIView commitAnimations];
}

-(void)returnNormalPath
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    self.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2);
    [UIView commitAnimations];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _numText){
        [self changeViewPath];
    }
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _numText)
    {
        [_pwdText becomeFirstResponder];
        [self changeViewPath];
        return YES;
    }
    [_pwdText resignFirstResponder];
    [self returnNormalPath];
    return YES;
}
@end
