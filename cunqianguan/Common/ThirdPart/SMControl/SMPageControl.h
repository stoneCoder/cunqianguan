//
//  UIBannerView.h
//  ControlTest
//
//  Created by apple on 14-3-2.
//  Copyright (c) 2014年 fezo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMPageControl : UIView

@property (nonatomic) NSUInteger currentPageIndex; // 0-no page 1-first page and so on.
@property (readonly, nonatomic, weak) UIView *currentPage;

- (id)initWithFrame:(CGRect)frame;

- (void)insertBannerPages:(UIView*)page;
- (void)removeAllBannerPages;

@end
