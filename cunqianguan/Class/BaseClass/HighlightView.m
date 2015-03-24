//
//  HighlightView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HighlightView.h"

@implementation HighlightView
-(void)setNormalBgColor:(UIColor *)normalBgColor andHighlightedBgColor:(UIColor *)highlightedBgColor
{
    [self setNormalBgColor:normalBgColor];
    [self setHighlightedBgColor:highlightedBgColor];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = _highlightedBgColor;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = _normalBgColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = _normalBgColor;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = _normalBgColor;
}

@end
