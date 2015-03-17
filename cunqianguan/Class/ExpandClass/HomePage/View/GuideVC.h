//
//  GuideVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/17.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseVC.h"
#import "GuideView.h"
#import "CustomPageControl.h"
@interface GuideVC : BaseVC<UIScrollViewDelegate>
@property (strong, nonatomic) GuideView *guideView;
@property (strong, nonatomic) CustomPageControl *pageControl;
@end
