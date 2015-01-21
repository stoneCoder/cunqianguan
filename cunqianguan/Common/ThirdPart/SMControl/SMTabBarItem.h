//
//  SMTabBarItem.h
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-17.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewController.h"

// UITabBarItem
// UIButton

@interface SMTabBarItem : UIControl

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *selectedImage;

@property (nonatomic,strong) UIView          *titleView;

@end
