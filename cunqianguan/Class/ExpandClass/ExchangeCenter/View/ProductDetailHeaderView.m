//
//
//  ProductDetailHeaderView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ProductDetailHeaderView.h"
#import "UIImage+Resize.h"

@implementation ProductDetailHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(ProductDetailHeaderView *)headerView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    ProductDetailHeaderView *productDetailHeaderView = nil;
    if ([nibs count]) {
        productDetailHeaderView = [nibs objectAtIndex:0];
    }
    return productDetailHeaderView;
}

-(void)loadData:(ExChangeModel *)model
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    CGRect frame = _scrollview.frame;
    frame.size.width = SCREEN_WIDTH;
    imageView.frame = frame;
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.image = [image imageByScalingAndCroppingForSize:imageView.frame.size];
    }];
    [_scrollview addSubview:imageView];
    
    _titleLabel.text = model.title;
    
    _pointLabel.text = [NSString stringWithFormat:@"%ld积分",(long)model.point];
}


//-(void)loadPage:(ProductDetailModel *)model{
//   
//    CGSize lageSize=[self.oldPriceLab sizeThatFits:CGSizeMake(50, 21)];
//    UIView * line=[[UIView alloc]initWithFrame:CGRectMake(126, 20, 35+11+lageSize.width, 1)];
//    line.backgroundColor=[UIColor lightGrayColor];
//    line.hidden=YES;
//    [self.priceView addSubview:line];
//    
//    
//    
//    
//    int count=model.galleryList.count;
//    int _x=0;
//    for (int index=0; index<count; index++) {
//        UIImageView * imgView=[[UIImageView alloc]initWithFrame:CGRectMake(_x, 0, self.frame.size.width, 160)];
//        [imgView sd_setImageWithURL:[NSURL URLWithString:model.galleryList[index]] placeholderImage:[UIImage imageNamed:@"product_lunbo_placeholder"]];
//        [_scrollView addSubview:imgView];
//                _x+=320;
//    }
//    _pageControl.numberOfPages=count;
//    _scrollView.contentSize=CGSizeMake(self.frame.size.width * count, 160);
//}
#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    int current= scrollView.contentOffset.x/320;
//    self.pageControl.currentPage=current;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
