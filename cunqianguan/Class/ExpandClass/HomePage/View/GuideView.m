//
//  GuideView.m
//  SmartXHSD
//
//  Created by 左德彪 on 14-4-8.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import "GuideView.h"

@interface GuideView ()

@property (strong, nonatomic) UIImageView *imageViewGuide1;
@property (strong, nonatomic) UIImageView *imageViewGuide2;
@property (strong, nonatomic) UIImageView *imageViewGuide3;

@end

@implementation GuideView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageViewGuide1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leader_01.png"]];
        self.imageViewGuide1.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH);
        self.imageViewGuide1.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.imageViewGuide1.backgroundColor = UIColorFromRGB(0x4f5d61);
        [self addSubview:self.imageViewGuide1];
        self.imageViewGuide2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leader_02.png"]];
        self.imageViewGuide2.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH);
        self.imageViewGuide2.center = CGPointMake(self.frame.size.width*3/2, self.frame.size.height/2);
        self.imageViewGuide2.backgroundColor = UIColorFromRGB(0x3bb4f2);
        [self addSubview:self.imageViewGuide2];
        self.imageViewGuide3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leader_03.png"]];
        self.imageViewGuide3.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH);
        self.imageViewGuide3.center = CGPointMake(self.frame.size.width*5/2, self.frame.size.height/2);
        self.imageViewGuide3.backgroundColor = UIColorFromRGB(0xf66969);
        [self addSubview:self.imageViewGuide3];
        
        self.buttonStart = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 45)];
        self.buttonStart.layer.cornerRadius = 3.0f;
        self.buttonStart.backgroundColor = [UIColor whiteColor];
        self.buttonStart.center = CGPointMake(self.frame.size.width*5/2, self.frame.size.height-70);
        self.buttonStart.titleLabel.font =  [UIFont boldSystemFontOfSize:17.0f];
        [self.buttonStart setTitle:@"立即体验" forState:UIControlStateNormal];
        [self.buttonStart setTitleColor:UIColorFromRGB(0xf66969) forState:UIControlStateNormal];
        [self addSubview:self.buttonStart];
        
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self setPagingEnabled:YES];
        [self setContentSize:CGSizeMake(self.frame.size.width*3, self.frame.size.height)];
    }
    return self;
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
