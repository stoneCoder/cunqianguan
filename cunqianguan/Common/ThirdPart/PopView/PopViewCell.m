//
//  RLInfoCell.m
//  manpower
//
//  Created by Brian on 14-6-30.
//  Copyright (c) 2014年 hanjin. All rights reserved.
//

#import "PopViewCell.h"

@implementation PopViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backImageView = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 5, 20, 12)];
        [self addSubview:self.backImageView];
        
        self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, -4, frame.size.width, frame.size.height)];
        self.infoLabel.font = [UIFont systemFontOfSize:15.0f];
        self.infoLabel.textAlignment = NSTextAlignmentLeft;
        self.infoLabel.textColor = [UIColor grayColor];
        self.infoLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.infoLabel];
        
       
        
    }
    return self;
}

-(void)updateBackImge:(int)type
{
    if (type == 1)
    {
        [self addTarget:self action:@selector(onTouchDown) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDownRepeat];
        [self addTarget:self action:@selector(onTouchUp) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel)];
    }
}

- (void)onTouchDown
{
    self.backgroundColor = [UIColor whiteColor];
    self.infoLabel.textColor = [UIColor blackColor];
}

- (void)onTouchUp
{
    self.backgroundColor = [UIColor whiteColor];
    self.infoLabel.textColor = [UIColor blackColor];
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
