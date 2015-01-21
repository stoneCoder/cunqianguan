//
//  SMViewController.h
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-18.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMTabBarItem;
@class SMNavigationItem;
@class SMNavigationController;
@class SMTabBarController;

@interface SMViewController : UIViewController {
    @private
    SMNavigationController *_navigationController;
    SMTabBarController *_tabBarController;
}

@end
