//
//  PopView.m
//  GM86
//
//  Created by Brian on 14-7-18.
//  Copyright (c) 2014年 WHZM. All rights reserved.
//

#import "PopView.h"

@implementation PopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.popView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 155, 60)];
        self.myAttentionView = [[PopViewCell alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)];
        self.myAttentionView.infoLabel.text = @"只显示我关注的游戏";
        self.myAttentionView.infoLabel.frame = CGRectMake(25, -1, self.myAttentionView.frame.size.width, self.myAttentionView.frame.size.height);
        [self.myAttentionView.backImageView setFrame:CGRectMake(0, 5, 20, 20)];
        self.myAttentionView.backImageView.image = [UIImage imageNamed:@"checkbox_white_bg_normal"];
        [self addSubview:self.myAttentionView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(-10, frame.size.height/2 + 2, frame.size.width+20, 1)];
        //lineView.backgroundColor = XianBgColor;
        [self addSubview:lineView];
        
        self.manageAttentionView = [[PopViewCell alloc] initWithFrame:CGRectMake(0, frame.size.height/2+10, frame.size.width, frame.size.height/2)];
        [self.manageAttentionView updateBackImge:1];
        self.manageAttentionView.infoLabel.text = @"管理我关注的游戏";
        self.manageAttentionView.backImageView.image = [UIImage imageNamed:@"eye_icon_normal"];
        [self addSubview:self.manageAttentionView];
        //[self.manageAttentionView addTarget:self action:@selector(manageMyGame) forControlEvents:UIControlEventTouchUpInside];
        
        
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
