//
//  PageHeaderView.h
//  Cntianran
//
//  Created by hanjin on 14-8-21.
//  Copyright (c) 2014年 INMEDIA. All rights reserved.
//

#import "BaseView.h"
@protocol PageHeaderViewDelegate <NSObject>
-(void)selectedPage:(NSUInteger)index;
@end


@interface AdvertiseView : BaseView<UIScrollViewDelegate>
@property (strong,nonatomic) UIScrollView * scrollView;
@property (strong,nonatomic) UIPageControl * pageControl;
@property (assign,nonatomic) id<PageHeaderViewDelegate> delegate;
@end
