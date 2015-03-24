//
//  HighlightView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighlightView : UIView
@property (nonatomic, strong) UIColor *highlightedBgColor;
@property (nonatomic, strong) UIColor *normalBgColor;
-(void)setNormalBgColor:(UIColor *)normalBgColor andHighlightedBgColor:(UIColor *)highlightedBgColor;
@end
