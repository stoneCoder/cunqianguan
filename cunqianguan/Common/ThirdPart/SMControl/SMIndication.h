//
//  UIBannerIndicationView.h
//  ControlTest
//
//  Created by apple on 14-3-2.
//  Copyright (c) 2014年 fezo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMIndication : UIView

@property (nonatomic, assign) BOOL indicating;
@property (nonatomic, assign) BOOL fillIndication;
@property (strong, nonatomic) UIColor *indicationColor;
@property (strong, nonatomic) UIColor *unindicationColor;
@property (nonatomic, assign) CGFloat lineWidth;

//@property (strong,nonatomic) UIImageView *imageView;

@end
