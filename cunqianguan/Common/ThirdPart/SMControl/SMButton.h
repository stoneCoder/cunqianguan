//
//  SMButton.h
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-24.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMButton : UIControl

@property (strong, nonatomic) UILabel *textLabel;

- (void)setTitleColor:(UIColor*)color highlight:(UIColor*)hColor;

- (void)setBackgroundColor:(UIColor*)color highlight:(UIColor*)hColor;

@end
