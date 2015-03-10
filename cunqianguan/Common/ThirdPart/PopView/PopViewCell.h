//
//  RLInfoCell.h
//  manpower
//
//  Created by Brian on 14-6-30.
//  Copyright (c) 2014年 hanjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopViewCell : UIControl

@property (strong,nonatomic) UIImageView *backImageView;
@property (strong,nonatomic) UILabel *infoLabel;

-(void)updateBackImge:(int)type;
@end
