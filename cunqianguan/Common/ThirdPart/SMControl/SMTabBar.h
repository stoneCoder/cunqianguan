//
//  SMTabBar.h
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-17.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMTabBarItem.h"

// UITabBar
@interface SMTabBar : UIView

@property(nonatomic,assign) SMTabBarItem *selectedItem;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *selectedTitleColor;
@property (strong, nonatomic) UIImage *backgroundImage;

- (void)setTabBarItems:(NSArray *)items;
- (void)addTabBarItem:(SMTabBarItem*)item;

@end
