//
//  SMNavigationItem.m
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-18.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import "SMNavigationItem.h"
#import "SMNavigationBar.h"

@interface SMNavigationItem ()

- (void)setNavigationBar:(SMNavigationBar*)bar;

@end

@implementation SMNavigationItem

- (id)init
{
    self = [super init];
    if (self) {
        //_navigationBar = [[SMNavigationBar alloc] init];
    }
    return self;
}

- (void)setTitleView:(UIView *)titleView
{
    [_navigationBar setTitleView:titleView];
    [_navigationBar setNeedsLayout];
}

- (void)setNavigationBar:(SMNavigationBar*)bar
{
    _navigationBar = bar;
}

@end