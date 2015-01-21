//
//  SMButton.m
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-24.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import "SMButton.h"

@interface SMButton ()

@property (strong, nonatomic) UIColor *textLabelNormal;
@property (strong, nonatomic) UIColor *textLabelHighlight;
@property (strong, nonatomic) UIColor *backgroundNormalColor;
@property (strong, nonatomic) UIColor *backgroundHighlighColor;
@property (assign, nonatomic) BOOL touching;

@end

@implementation SMButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.userInteractionEnabled = NO;
        self.textLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.textLabel];
        
        self.textLabelNormal = [UIColor whiteColor];
        self.textLabelHighlight = [UIColor grayColor];
        self.backgroundNormalColor = [UIColor redColor];
        self.backgroundHighlighColor = [UIColor colorWithRed:201/255.0f green:55/255.0f blue:86/255.0f alpha:1.0f];
        
        self.textLabel.textColor = self.textLabelNormal;
        self.textLabel.backgroundColor = self.backgroundNormalColor;
        
        [self addTarget:self action:@selector(onTouchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(onTouchUp) forControlEvents:(UIControlEventTouchUpInside |  UIControlEventTouchUpOutside | UIControlEventTouchCancel)];
    }
    return self;
}

- (void)setTitleColor:(UIColor*)color highlight:(UIColor*)hColor
{
    self.textLabelNormal = color;
    self.textLabelHighlight = hColor;
    [self setNeedsLayout];
}

- (void)setBackgroundColor:(UIColor*)color highlight:(UIColor*)hColor
{
    self.backgroundNormalColor = color;
    self.backgroundHighlighColor = hColor;
    [self setNeedsLayout];
}

- (void)onTouchDown
{
    self.touching = YES;
    [self setNeedsLayout];
}

- (void)onTouchUp
{
    self.touching = NO;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.touching) {
        self.textLabel.textColor = self.textLabelHighlight;
        self.textLabel.backgroundColor = self.backgroundHighlighColor;
    } else {
        self.textLabel.textColor = self.textLabelNormal;
        self.textLabel.backgroundColor = self.backgroundNormalColor;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
