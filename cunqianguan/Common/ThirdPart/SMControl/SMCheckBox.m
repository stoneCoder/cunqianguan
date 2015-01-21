//
//  SMCheckBox.m
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-24.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import "SMCheckBox.h"

@interface SMCheckBox ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation SMCheckBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.checked = YES;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 16, 16)];
        self.imageView.userInteractionEnabled = NO;
        self.imageView.image = [UIImage imageNamed:@"checkbox_full.png"];
        [self addSubview:self.imageView];
        
        self.labelText = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width-20, self.frame.size.height)];
        self.labelText.font = [UIFont systemFontOfSize:12.0f];
        self.labelText.userInteractionEnabled = NO;
        [self addSubview:self.labelText];
        
        [self addTarget:self action:@selector(onTouchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(onTouchUp) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside)];
    }
    return self;
}

- (void)onTouchDown
{
    self.checked = !self.checked;
    self.imageView.image = self.checked?[UIImage imageNamed:@"checkbox_full.png"]:[UIImage imageNamed:@"checkbox_empty.png"];
}

- (void)onTouchUp
{
    
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
