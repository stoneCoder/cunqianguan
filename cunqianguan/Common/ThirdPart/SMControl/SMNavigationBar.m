//
//  SMNavigationBar.m
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-18.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import "SMNavigationBar.h"

@implementation SMNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews
{
    if (self.leftView) {
        [self.leftView layoutIfNeeded];
        self.leftView.frame = CGRectMake(0, 0, self.leftView.frame.size.width, self.leftView.frame.size.height);
    }
    if (self.titleView) {
        [self.titleView layoutIfNeeded];
        self.titleView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
    if (self.rightView) {
        [self.rightView layoutIfNeeded];
        self.rightView.frame = CGRectMake(self.frame.size.width-self.rightView.frame.size.width-5, 10, self.rightView.frame.size.width, self.rightView.frame.size.height);
    }
    [super layoutSubviews];
}

- (void)setLeftView:(UIView *)leftView
{
    if (_leftView) {
        [_leftView removeFromSuperview];
    }
    _leftView = leftView;
    [self addSubview:_leftView];
    [self setNeedsLayout];
}

- (void)setTitleView:(UIView *)titleView
{
    if (_titleView) {
        [_titleView removeFromSuperview];
    }
    _titleView = titleView;
    [self addSubview:_titleView];
    [self setNeedsLayout];
}

- (void)setRightView:(UIView *)rightView
{
    if (_rightView) {
        [_rightView removeFromSuperview];
    }
    _rightView = rightView;
    [self addSubview:_rightView];
    [self setNeedsLayout];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, self.frame.size.height);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    CGContextStrokePath(context);
}

@end
