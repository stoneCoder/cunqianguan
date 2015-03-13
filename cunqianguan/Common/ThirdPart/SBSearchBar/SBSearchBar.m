//
//  SBSearchBar.m
//  SBSearchBarExample
//
//  Created by Santiago Bustamante on 4/29/14.
//  Copyright (c) 2014 Busta. All rights reserved.
//

#import "SBSearchBar.h"

@implementation SBSearchBar
{
    UIColor *textColor;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(2, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 5)];
        self.searchTextField.placeholder = @"输入宝贝关键字查返利";
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        [self.cancelButton setImage:[UIImage imageNamed:@"inner_search_btn"] forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void) setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.searchTextField.frame = CGRectMake(2, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self willMoveToSuperview:nil];
}

- (void) willMoveToSuperview:(UIView *)newSuperview{
    
    self.searchTextField.delegate = self;
    //self.searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.searchTextField setReturnKeyType:UIReturnKeySearch];
    [self addSubview:self.searchTextField];
    [self.searchTextField setTextColor:textColor];
    

    CGRect frame = self.searchTextField.frame;
    frame.origin = CGPointZero;
    frame.origin.x = 0;
    frame.size.width = CGRectGetWidth(self.frame) - CGRectGetWidth(self.cancelButton.frame) - 15;
    self.searchTextField.frame = frame;
    
    
    [self addSubview:self.cancelButton];
    
    frame = self.cancelButton.frame;
    frame.origin.x = CGRectGetWidth(self.frame) - CGRectGetWidth(frame) - 10;
    frame.origin.y = CGRectGetHeight(self.frame)/2 - CGRectGetHeight(frame)/2;
    self.cancelButton.frame = frame;
    
}

-(void) setCancelButtonImage:(UIImage *)cancelButtonImage{
    _cancelButtonImage = cancelButtonImage;
    if (!self.cancelButton) {
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [self.cancelButton removeFromSuperview];
    [self.cancelButton setBackgroundImage:_cancelButtonImage forState:UIControlStateNormal];
    CGRect frame = self.cancelButton.frame;
    frame.size = _cancelButtonImage.size;
    self.cancelButton.frame = frame;
    [self.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
}

-(void)searchBtnAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchAction:)]) {
        [self.delegate searchAction:self];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarShouldBeginEditing:)]) {
        [self.delegate SBSearchBarShouldBeginEditing:self];
    }
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarTextDidBeginEditing:)]) {
        [self.delegate SBSearchBarTextDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarShouldEndEditing:)]) {
        [self.delegate SBSearchBarShouldEndEditing:self];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarSearchButtonClicked:)]) {
        [self.delegate SBSearchBarSearchButtonClicked:self];
    }else{
        [self.searchTextField resignFirstResponder];
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarTextDidEndEditing:)]) {
        [self.delegate SBSearchBarTextDidEndEditing:self];
    }
}


-(NSString *) text{
    return self.searchTextField.text;
}

- (BOOL) resignFirstResponder{
    return [self.searchTextField resignFirstResponder];
}

-(void) setFont:(UIFont *)font{
    _font = font;
    [self.searchTextField setFont:font];
}

-(void) setTextColor:(UIColor *)color{
    textColor = color;
    if (self.searchTextField.superview) {
      [self.searchTextField setTextColor:color];
    }
}

- (void) setPlaceHolderColor:(UIColor *)color{
    _placeHolderColor = color;
    self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.searchTextField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
}

-(void)setPlaceHolderText:(NSString *)text{
    self.searchTextField.placeholder = text;
}

- (void) cancelAction:(id) sender{
    self.searchTextField.text = @"";
    [self resignFirstResponder];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(SBSearchBarCancelButtonClicked:)]) {
        [self.delegate SBSearchBarCancelButtonClicked:self];
    }
}


@end
