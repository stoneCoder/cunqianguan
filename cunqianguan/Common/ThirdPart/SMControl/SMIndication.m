//
//  UIBannerIndicationView.m
//  ControlTest
//
//  Created by apple on 14-3-2.
//  Copyright (c) 2014年 fezo. All rights reserved.
//

#import "SMIndication.h"

@implementation SMIndication

@synthesize indicating = _indicating;

- (void)setIndicating:(BOOL)indicating
{
    _indicating = indicating;
    //[self setNeedsDisplay];
    _imageView.highlighted = _indicating;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qiehuan"] highlightedImage:[UIImage imageNamed:@"qiehuan_hover"]];
    [self addSubview:_imageView];
    if (self) {
        self.indicating = NO;
        self.fillIndication = YES;
        self.lineWidth = 1;
        self.layer.borderWidth = 0;
        self.backgroundColor = [UIColor clearColor];
        self.indicationColor = [UIColor redColor];
        self.unindicationColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsPushContext(context);
    
    CGContextSetStrokeColorWithColor(context, [self.indicationColor CGColor]);
    CGContextSetFillColorWithColor(context, _indicating?[self.indicationColor CGColor]:[self.unindicationColor CGColor]);
    CGContextSetLineWidth(context, self.lineWidth);
    CGMutablePathRef startPath = CGPathCreateMutable();
    
    CGPathAddArc(startPath, NULL, self.frame.size.width/2, self.frame.size.height/2, self.frame.size.width/2-1, 0, 360, 0);
    CGContextAddPath(context, startPath);
    self.fillIndication?CGContextFillPath(context):CGContextStrokePath(context);
    CFRelease(startPath);
    UIGraphicsPopContext();
    [super drawRect:rect];
}

@end
