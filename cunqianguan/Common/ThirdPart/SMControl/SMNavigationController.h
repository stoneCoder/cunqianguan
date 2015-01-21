//
//  SMNavigationController.h
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-18.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMViewController.h"
#import "SMConstant.h"

@class SMNavigationItem;
@class SMNavigationBar;

// UINavigationController
@interface SMNavigationController : SMViewController

@property(nonatomic,readonly,strong) SMViewController *topViewController;
@property(nonatomic,readonly,strong) SMViewController *visibleViewController;

- (id)initWithRootViewController:(SMViewController *)rootViewController; // Convenience method pushes the root view controller without animation.

- (void)pushViewController:(SMViewController *)viewController animated:(BOOL)animated; // Uses a horizontal slide transition. Has no effect if the view controller is already in the stack.

- (SMViewController *)popViewControllerAnimated:(BOOL)animated; // Returns the popped controller.

@property(nonatomic,copy) NSArray *viewControllers; // The current view controller stack.
- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated NS_AVAILABLE_IOS(3_0); // If animated is YES, then simulate a push or pop depending on whether the new top view controller was previously in the stack.

@property(nonatomic,getter=isNavigationBarHidden) BOOL navigationBarHidden;
- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated; // Hide or show the navigation bar. If animated, it will transition vertically using UINavigationControllerHideShowBarDuration.
@property(nonatomic,readonly, strong) SMNavigationBar *navigationBar; // The navigation bar managed by the controller. Pushing, popping or setting navigation items on a managed navigation bar is not supported.

@end

@interface SMViewController (SMNavigationItem)

@property (nonatomic,readonly, strong) SMNavigationItem *navigationItem; // Created on-demand so that a view controller may customize its navigation appearance.
@property (nonatomic) BOOL hidesBottomBarWhenPushed; // If YES, then when this view controller is pushed into a controller hierarchy with a bottom bar (like a tab bar), the bottom bar will slide out. Default is NO.
@property (nonatomic,readonly, strong) SMNavigationController *navigationController;

@end