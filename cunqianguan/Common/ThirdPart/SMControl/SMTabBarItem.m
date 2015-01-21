//
//  SMTabBarItem.m
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-17.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import "SMTabBarItem.h"

#define MARGIN_LEN 5
#define TITLE_LABEL_HEIGHT 20

@interface SMTabBarItem ()

@end

@implementation SMTabBarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        self.titleLabel.textColor = [UIColor grayColor];
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    NSLog(@"height=%f", self.frame.size.height);
    CGFloat imageSize = MIN(self.frame.size.width, self.frame.size.height-2*MARGIN_LEN-TITLE_LABEL_HEIGHT);
    self.imageView.frame = CGRectMake(0, 0, imageSize, imageSize);
    self.imageView.center = CGPointMake(self.frame.size.width/2, MARGIN_LEN + (self.frame.size.height-2*MARGIN_LEN-TITLE_LABEL_HEIGHT)/2);
    self.imageView.image = self.image;
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height-TITLE_LABEL_HEIGHT-MARGIN_LEN, self.frame.size.width, TITLE_LABEL_HEIGHT);
    self.titleLabel.text = self.title;
    [super layoutSubviews];
}

@end

