//
//  TouchPropagatedScrollView.m
//
//  Created by chen on 14/7/13.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "TouchPropagatedScrollView.h"

@interface TouchPropagatedScrollView ()
{
    NSMutableArray *btns;
    NSMutableArray *views;
    float lineViewWidth;
    float lineViewHeight;
    BOOL _isShowLine;
}

@property (nonatomic, weak) UIView * lineView;
@end

@implementation TouchPropagatedScrollView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initUI];
    }
    return self;
}

-(void)_initUI
{
    lineViewHeight = 2;
    btns = [[NSMutableArray alloc] init];
    views = [[NSMutableArray alloc] init];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = UIColorFromRGB(0x49c6db);
    [self addSubview:view];
    self.lineView = view;
}

- (void)setItems:(NSArray *)items isShowLine:(BOOL)isShowLine
{
    _isShowLine = isShowLine;
    lineViewWidth = self.contentSize.width / items.count;
    if ([items isEqualToArray:_items]) {
        return;
    }
    _items = items;
    for (UIView *view in btns) {
        [view removeFromSuperview];
    }
    [btns removeAllObjects];
    
    for (int i = 0; i < items.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitleColor:UIColorFromRGB(0x49c6db) forState:UIControlStateSelected];
        [btn setTitleColor:UIColorFromRGB(0x464646) forState:UIControlStateNormal];
        [btn setTitle:items[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        if (self.selectIndex == i) {
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btns addObject:btn];
    }
    if (_isShowLine) {
        for (int i = 1; i < items.count; i++) {
            UIView *fenggeView = [[UIView alloc] init];
            fenggeView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
            [self addSubview:fenggeView];
            [views addObject:fenggeView];
        }
        [self bringSubviewToFront:self.lineView];
    }
    [self layoutSubviews];
}

- (void)setSelectIndex:(NSUInteger)selectIndex
{
    [self setSelectIndex:selectIndex animated:NO];
}

- (void)setSelectIndex:(NSUInteger)selectIndex animated:(BOOL)animated
{
    if (_selectIndex >= _items.count) {
        return;
    }
    UIButton *btn = [btns objectAtIndex:_selectIndex];
    btn.selected = NO;
    _selectIndex = selectIndex;
    btn = [btns objectAtIndex:_selectIndex];
    btn.selected = YES;
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
    }
    self.lineView.center = CGPointMake(((_selectIndex+1)*2-1) * (btn.frame.size.width/2), self.lineView.center.y);
    if (animated) {
        [UIView commitAnimations];
    }
}

- (void)setBottomLineViewWidth:(CGFloat)width {
    if (width == lineViewWidth) {
        return;
    }
    lineViewWidth = width;
}

- (void)setItemTitleColorForNormal:(UIColor *)normal andForSelected:(UIColor *)selected {
    for (UIButton *button in btns) {
        [button setTitleColor:normal forState:UIControlStateNormal];
        [button setTitleColor:selected forState:UIControlStateSelected];
    }
}

- (void)setItemTitleFontSize:(CGFloat)size {
    for (UIButton *button in btns) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)hiddenSeparatorView:(BOOL)hidden {
    for (UIView *view in views) {
        view.hidden = hidden;
    }
}

#pragma mark -

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float width = self.contentSize.width / btns.count;
    if (_isShowLine) {
        for (int i = 1; i < btns.count; i++) {
            UIView *view = [views objectAtIndex:i-1];
            view.frame  = CGRectMake(width * i, 0, 1, self.bounds.size.height / 2);
            view.center = CGPointMake(view.center.x, self.bounds.size.height / 2);
        }
    }
    for (int i = 0; i < btns.count; i++) {
        UIView *view = [btns objectAtIndex:i];
        view.frame  = CGRectMake(width * i, 0, width, self.bounds.size.height);
        if (self.selectIndex == i) {
            self.lineView.frame = CGRectMake(_selectIndex * view.frame.size.width, self.bounds.size.height - self.lineView.frame.size.height, lineViewWidth, lineViewHeight);
            self.lineView.center = CGPointMake(((_selectIndex+1)*2-1) * (view.frame.size.width/2), self.lineView.center.y);
        }
    }
}

- (void)btnAction:(UIButton *)btn
{
    if (self.selectIndex == btn.tag) {
        return;
    }
    [self setSelectIndex:btn.tag animated:YES];
    [self selectIndex:btn.tag];
}

-(void)selectIndex:(NSInteger)index
{
    if (self.segmentDelegate && [self.segmentDelegate respondsToSelector:@selector(selectIndex:)]) {
        [self.segmentDelegate selectIndex:index];
    }
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
	return YES;
}

@end
