//
//  EmptyView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/12.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "DefaultEmptyView.h"

@implementation DefaultEmptyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(DefaultEmptyView *)init
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    DefaultEmptyView *emptyView = nil;
    if ([nibs count]) {
        emptyView = [nibs objectAtIndex:0];
    }
    return emptyView;
}
@end
