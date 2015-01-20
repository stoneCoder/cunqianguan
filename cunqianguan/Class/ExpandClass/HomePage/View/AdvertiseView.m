//
//  PageHeaderView.m
//  Cntianran
//
//  Created by hanjin on 14-8-21.
//  Copyright (c) 2014年 INMEDIA. All rights reserved.
//

#import "AdvertiseView.h"
#import "UIButton+WebCache.h"
@implementation AdvertiseView
@synthesize scrollView=_scrollView,pageControl=_pageControl;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect rect=frame;
        _scrollView=[[UIScrollView alloc]initWithFrame:rect];
        _scrollView.backgroundColor=[UIColor whiteColor];
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.pagingEnabled=YES;
        _scrollView.delegate=self;
        [self addSubview:_scrollView];
        
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(200, rect.size.height-15, 320-200, 15)];
        //_pageControl.backgroundColor=[UIColor colorWithWhite:1.0 alpha:0.4];
        _pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
        _pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
        _pageControl.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [self addSubview:self.pageControl];
        
    }
    return self;
}

//-(void)loadPage:(HomeReturnObjModel *)objModel{
//    for (UIButton * btn in _scrollView.subviews) {
//        if (btn) {
//            [btn removeFromSuperview];
//        }
//    }
//    
//    int _x=0;
//    for (int index=0; index<objModel.lunbo.count; index++) {
//        HomeLunboModel * model=objModel.lunbo[index];
//        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        btn.adjustsImageWhenHighlighted=NO;
//        btn.frame=CGRectMake(_x, 0, 320, 118);
//        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"homepage_lunbo_placeholder"]];
//        [btn addTarget:self action:@selector(tuchInPageView:) forControlEvents:UIControlEventTouchUpInside];
//        btn.tag=index;
//        [_scrollView addSubview:btn];
//        
//        _x+=320;
//    }
//    _pageControl.numberOfPages=objModel.lunbo.count;
//    _scrollView.contentSize=CGSizeMake(320 * objModel.lunbo.count, 118);
//}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int current= scrollView.contentOffset.x/320;
    self.pageControl.currentPage=current;
    
}


#pragma mark - Action
-(void)tuchInPageView:(UIButton *)sender{
    NSUInteger tag = sender.tag;
    [self.delegate selectedPage:tag];
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
