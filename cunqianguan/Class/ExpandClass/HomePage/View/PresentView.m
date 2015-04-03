//
//  PresentView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PresentView.h"

@implementation PresentView
{
    PresentTableView *_presentTable;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.3];
        [self setUpView];
    }
    return self;
}

-(void)setUpView
{
    
    CGFloat visiableHeight = 360.0f;
    CGFloat visiableY = SCREEN_HEIGTH - visiableHeight;
    _presentTable = [[PresentTableView alloc] initWithFrame:CGRectMake(0, visiableY, self.frame.size.width,visiableHeight) style:UITableViewStylePlain];
    _presentTable.backgroundColor = UIColorFromRGB(0xECECEC);
    _presentTable.scrollEnabled = NO;
    _presentTable.delegate = _presentTable;
    _presentTable.dataSource = _presentTable;
    _presentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_presentTable];
    
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    _closeBtn.center = ccp(self.frame.size.width/2,visiableY- 30);
    [_closeBtn addTarget:self action:@selector(hideMenu) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeBtn];
}

-(void)hideMenu
{
    if (_delegate && [_delegate respondsToSelector:@selector(hidePresentMenu)]) {
        [_delegate hidePresentMenu];
    }
}

@end
