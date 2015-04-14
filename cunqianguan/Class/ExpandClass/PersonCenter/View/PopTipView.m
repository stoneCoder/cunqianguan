//
//  PopTipView.m
//  cunqianguan
//
//  Created by 张 磊 on 15-3-17.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PopTipView.h"
#import "BaseUtil.h"
@implementation PopTipView
{
    UIImageView *_bgImageView;
    UILabel *_infoLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.frame];
        _bgImageView.image = [UIImage imageNamed:@"jifen"];
        [self addSubview:_bgImageView];
        
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, 10)];
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.font = [UIFont systemFontOfSize:12.0f];
        [_bgImageView addSubview:_infoLabel];
    }
    return  self;
}

-(void)loadViewWith:(NSString *)str
{
//    NSString *str = [NSString stringWithFormat:@"%ld/%ld",(long)_info.userExp,(long)_info.nextUserExp];

    _infoLabel.text = str;
//    [_popTipView setCenter:CGPointMake(frame.size.width/2 + 30, frame.origin.y - _popTipView.frame.size.height/2)];
//    [personHeaderView addSubview:_popTipView];
}
@end
