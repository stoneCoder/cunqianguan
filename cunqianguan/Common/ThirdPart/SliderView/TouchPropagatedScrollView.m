//
//  TouchPropagatedScrollView.m
//
//  Created by chen on 14/7/13.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "TouchPropagatedScrollView.h"
#import "UIView+Borders.h"
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
    btns = [[NSMutableArray alloc] init];
    views = [[NSMutableArray alloc] init];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = UIColorFromRGB(0x58DED4);
    [self addSubview:view];
    self.lineView = view;
}

- (void)setItems:(NSArray *)items isShowLine:(BOOL)isShowLine
{
    _isShowLine = isShowLine;
    if (_DirectionType == HorizontalDirection) {
        lineViewHeight = 2;
        lineViewWidth = self.contentSize.width / items.count;
    }else if (_DirectionType == VerticalDirection){
        lineViewHeight = self.contentSize.height / items.count;
        lineViewWidth = 5;
    }
    
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
        [btn setTitleColor:UIColorFromRGB(0x2cb8ad) forState:UIControlStateSelected];
        [btn setTitleColor:UIColorFromRGB(0x464646) forState:UIControlStateNormal];
        [btn setTitle:items[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        if (_isShowSelectBackgroundColor) {
            btn.backgroundColor = UIColorFromRGB(0xececec);
        }
        if (self.selectIndex == i) {
            btn.selected = YES;
            if (_isShowSelectBackgroundColor) {
               btn.backgroundColor = [UIColor whiteColor];
            }
        }
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btns addObject:btn];
    }
    if (_isShowLine) {
        for (int i = 1; i < items.count; i++) {
            UIView *fenggeView = [[UIView alloc] init];
            fenggeView.backgroundColor = UIColorFromRGB(0xececec);
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

    if (_isBorderStyle) {
        [btn addRightBorderWithWidth:1.0f andColor:UIColorFromRGB(0xc3c3c3)];
    }
    
    if (_isShowSelectBackgroundColor) {
        btn.backgroundColor = UIColorFromRGB(0xececec);
    }
    _selectIndex = selectIndex;
    btn = [btns objectAtIndex:_selectIndex];
    btn.selected = YES;

    if (_isBorderStyle) {
        [btn addRightBorderWithWidth:1.0f andColor:[UIColor whiteColor]];
    }
    
    if (_isShowSelectBackgroundColor) {
        btn.backgroundColor = [UIColor whiteColor];
    }
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
    }
    switch (_DirectionType) {
        case HorizontalDirection:
            self.lineView.center = CGPointMake(((_selectIndex+1)*2-1) * (btn.frame.size.width/2), self.lineView.center.y);
            break;
        case VerticalDirection:
            self.lineView.center = CGPointMake(self.lineView.center.x, ((_selectIndex+1)*2-1) * (btn.frame.size.height/2));
            break;
        default:
            break;
    }
    
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
    float height = self.contentSize.height / btns.count;
    if (_isShowLine) {
        for (int i = 1; i < btns.count; i++) {
            UIView *view = [views objectAtIndex:i-1];
            switch (_DirectionType) {
                case HorizontalDirection:
                    view.frame  = CGRectMake(width * i, 0, 1, self.bounds.size.height / 2);
                    view.center = CGPointMake(view.center.x, self.bounds.size.height / 2);
                    break;
                case VerticalDirection:
                    view.frame  = CGRectMake(0, height * i, self.bounds.size.width, 1);
                    //view.center = CGPointMake(self.bounds.size.width / 2, view.center.y);
                    break;
                default:
                    break;
            }
        }
    }
    for (int i = 0; i < btns.count; i++) {
        UIView *view = [btns objectAtIndex:i];
        switch (_DirectionType) {
            case HorizontalDirection:
                view.frame  = CGRectMake(width * i, 0, width, self.bounds.size.height);
                break;
            case VerticalDirection:
                view.frame  = CGRectMake(0, height * i, self.bounds.size.width, height);
                if (_isBorderStyle) {
                    [view addBottomBorderWithHeight:1.0f andColor:UIColorFromRGB(0xc3c3c3)];
                    [view addRightBorderWithWidth:1.0f andColor:UIColorFromRGB(0xc3c3c3)];
                }
                
                break;
            default:
                break;
        }
        if (self.selectIndex == i) {
            switch (_DirectionType) {
                case HorizontalDirection:
                    self.lineView.frame = CGRectMake(_selectIndex * view.frame.size.width, self.bounds.size.height - self.lineView.frame.size.height, lineViewWidth, lineViewHeight);
                    self.lineView.center = CGPointMake(((_selectIndex+1)*2-1) * (view.frame.size.width/2), self.lineView.center.y);
                    break;
                case VerticalDirection:
                    self.lineView.frame = CGRectMake(0, _selectIndex * view.frame.size.height, lineViewWidth, lineViewHeight);
                    self.lineView.center = CGPointMake(self.lineView.center.x, ((_selectIndex+1)*2-1) * (view.frame.size.height/2));
                    [view addRightBorderWithWidth:1.0f andColor:[UIColor whiteColor]];
                    break;
                default:
                    break;
            }
            
        }
    }
}

- (void)btnAction:(UIButton *)btn
{
    if (self.selectIndex == btn.tag) {
        return;
    }
    [self setSelectIndex:btn.tag animated:YES];
    [self selectTitle:btn.titleLabel.text];
    [self selectIndex:btn.tag];
}

-(void)selectTitle:(NSString *)title;
{
    if (self.segmentDelegate && [self.segmentDelegate respondsToSelector:@selector(selectIndex:)]) {
        [self.segmentDelegate selectTitle:title];
    }
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
