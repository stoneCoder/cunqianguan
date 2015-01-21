//
//  SMTabBarController.h
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-17.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewController.h"
#import "SMTabBar.h"
#import "SMConstant.h"

// UITabBarController
@interface SMTabBarController : SMViewController

@property (strong, nonatomic) NSMutableArray *childControllers;

@property (nonatomic,weak) SMViewController *selectedViewController;
@property (nonatomic) NSUInteger selectedIndex;

@property (strong, nonatomic) SMTabBar *tabBar;

- (void)addChildViewController:(SMViewController *)childController;

@end

@interface SMViewController (SMTabBarControllerItem)

@property(nonatomic, strong) SMTabBarItem *tabBarItem; // Automatically created lazily with the view controller's title if it's not set explicitly.

@property(nonatomic,readonly,strong) SMTabBarController *tabBarController; // If the view controller has a tab bar controller as its ancestor, return it. Returns nil otherwise.

@end